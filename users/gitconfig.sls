# git configs
{{ homedir }}/.gitconfig.d:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - mode: 770

{{ homedir }}/.gitconfig.d/user:
  file.managed:
    - source: salt://users/files/gitconfig_user
    - user: {{ user }}
    - group: {{ user }}
    - mode: 600
    - template: jinja
    - context:
      full_name: {{ full_name }}
      email: {{ email }}
    - require:
      - cmd: {{ user }}_configs_init

# TODO via pillar
{{ homedir }}/.gitconfig.d/local:
  file.managed:
    - source: salt://users/files/gitconfig_local
    - user: {{ user }}
    - group: {{ user }}
    - mode: 600
    - require:
      - user: {{user }}
      - cmd: {{ user }}_configs_init


