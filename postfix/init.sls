{% set generic_map = salt['pillar.get']('postfix:generic_map', None) -%}

mailutils:
  pkg.installed

postfix:
  service.running:
    - watch:
      - file: /etc/postfix/main.cf

postfix_main_cf:
  file.managed:
    - name: /etc/postfix/main.cf
    - source: salt://postfix/files/main.cf
    - template: jinja
    - context:
      generic_map: {{ generic_map }}
    - mode: 600
    - require:
      - pkg: mailutils

{% if generic_map %}
# allows aliasing from unix user -> FROM mail addr
/etc/postfix/generic:
  file.managed:
    - source: salt://postfix/files/generic
    - template: jinja
    - context:
      generic_map: {{ generic_map }}
    - mode: 640
    - require:
      - pkg: mailutils

update_postfix_lookup_table:
  cmd.run:
    - name: postmap /etc/postfix/generic
    - onchanges:
      - file: /etc/postfix/generic
    - watch_in:
      - service: postfix
{% endif %}

