{% set target = salt['file.join'](homedir, 'configs') %}

git_for_{{ user }}_configs:
  pkg.installed:
    - name: git

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
      - pkg: git_for_{{ user }}_configs
{{ user }}_configs_init:
  cmd.wait:
    - name: ./init --force
    - cwd: {{ target }}
    - runas: {{ user }}
    - watch:
      - git: {{ user }}_configs

