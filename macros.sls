{% macro configs(user, require=True) %}

{% if user == 'root' %}
  {% set target = '/root/configs' %}
{% else %}
  {% set target = '/home/{0}/configs'.format(user) %}
{% endif %}

{{ user }}_configs:
  git.latest:
    - name: https://github.com/felixhummel/configs.git
    - rev: master
    - target: {{ target }}
    - user: {{ user }}
    - submodules: True
    {% if require %}
    - require:
      - user: {{ user }}
    {% endif %}

{{ user }}_configs_init:
  cmd.run:
    - name: ./init --force --skip-git
    - cwd: {{ target }}
    - user: {{ user }}
    - group: {{ user }}
    - onchanges:
      - git: {{ user }}_configs
{% endmacro %}
