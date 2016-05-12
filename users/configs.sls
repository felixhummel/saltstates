{% set target = '{0}/configs'.format(homedir) %}

# configs in general
{{ user }}_configs:
  git.latest:
    - name: {{ repo }}
    - rev: master
    - target: {{ target }}
    - user: {{ user }}
    - submodules: True
    - require:
      - user: user_{{ user }}
{{ user }}_configs_init:
  cmd.wait:
    - name: ./init --force --skip-git
    - cwd: {{ target }}
    - user: {{ user }}
    - group: {{ user }}
    - watch:
      - git: {{ user }}_configs

