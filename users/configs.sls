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

# git configs
{{ homedir }}/.gitconfig.d:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - mode: 700
    - require:
      - user: {{user }}
{{ homedir }}/.gitconfig.d/user:
  file.managed:
    - source: salt://users/files/gitconfig_user
    - user: {{ user }}
    - group: {{ user }}
    - mode: 600
    - template: jinja
    - context:
      full_name: {{ pillar['users'][user]['name'] }}
      email: {{ pillar['users'][user]['email'] }}
    - require:
      - file: {{ homedir }}/.gitconfig.d

# TODO via pillar
{{ homedir }}/.gitconfig.d/local:
  file.managed:
    - source: salt://users/files/gitconfig_local
    - user: {{ user }}
    - group: {{ user }}
    - mode: 600
    - require:
      - cmd: {{ user }}_configs_init

