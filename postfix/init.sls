{% set domain = salt['pillar.get']('postfix:domain') %}
{% set generic_map = salt['pillar.get']('postfix:generic_map', None) -%}
{% set dkim_dns_is_set = salt['pillar.get']('postfix:dkim:dns_is_set') %}

mailutils:
  pkg.installed

postfix:
  pkg.installed: []
  service.running:
    - watch:
      - file: /etc/mailname
      - file: /etc/postfix/main.cf

/etc/mailname:
  file.managed:
    - mode: 644
    - contents:
      - {{ domain }}

/etc/postfix/main.cf:
  file.managed:
    - source: salt://postfix/files/main.cf
    - template: jinja
    - context:
      generic_map: {{ generic_map }}
      {%- if dkim_dns_is_set %}
      milter_lines:
        - milter_protocol = 2
        - milter_default_action = accept
        # this is relative to postfix' chroot
        - smtpd_milters = unix:/var/run/opendkim/opendkim.sock
        - non_smtpd_milters = unix:/var/run/opendkim/opendkim.sock
      {%- endif %}
    - mode: 600
    - require:
      - pkg: postfix

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

{% if dkim_dns_is_set %}
opendkim:
  pkg.installed:
    - pkgs:
      - opendkim
      - opendkim-tools
  service.running:
    - watch:
      - file: /etc/default/opendkim
      - file: /etc/opendkim
      - file: /etc/opendkim.conf
      - file: /etc/opendkim/TrustedHosts
      - file: /etc/opendkim/KeyTable
      - file: /etc/opendkim/SigningTable

/etc/default/opendkim:
  file.managed:
    - source: salt://postfix/files/etc_default/opendkim

/etc/opendkim.conf:
  file.managed:
    - source: salt://postfix/files/opendkim.conf

/etc/opendkim:
  file.directory:
    - dir_mode: 700
    - user: opendkim
    - group: opendkim
    - dir_mode: 700
    - file_mode: 600
    - recurse:
      - user
      - group
      - mode

/etc/opendkim/TrustedHosts:
  file.managed:
    - contents_pillar: postfix:dkim:TrustedHosts
    - user: opendkim
    - group: opendkim
    - mode: 600
/etc/opendkim/KeyTable:
  file.managed:
    - contents_pillar: postfix:dkim:KeyTable
    - user: opendkim
    - group: opendkim
    - mode: 600
/etc/opendkim/SigningTable:
  file.managed:
    - contents_pillar: postfix:dkim:SigningTable
    - user: opendkim
    - group: opendkim
    - mode: 600
{% endif %}
