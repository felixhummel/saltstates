{% set salt_owner = pillar.get('salt_owner', None) %}

{% for user, p in pillar.get('users', {}).items() %}
user_{{ user }}:
  group.present:
    - name: {{ user }}
    - gid: {{ p.get('gid', '') }}
    - require_in:
      - user: user_{{ user }}
  user.present:
    - name: {{ user }}
    - fullname: {{ p['name'] }}
    - home: {{ p.get('home', '') }}
    - uid: {{ p.get('uid', '') }}
    - shell: {{ p.get('shell', '') }}
    - groups:
      - {{ user }}
      {% if p.get('admin', False) -%}
      - adm
      - sudo
      {%- endif %}
    - optional_groups:
      {% if p.get('admin', False) -%}
      - cdrom
      - dip
      - lpadmin
      - plugdev
      - sambashare
      - fuse
      - disk
      - docker
      {%- endif %}

{% if p.get('cleanup_home', False) -%}
# There should be a better way to clean up things here. I guess there is some skeleton, but I'm too lazy to find it now.
{% set dirs = 'Documents Music Pictures Public Templates Videos'.split() %}
{% for dir in dirs %}
/home/{{ user }}/{{ dir }}:
  file.absent:
    - require:
      - user: user_{{ user }}
{% endfor %}
{%- endif %}

{% if p.get('configs_repo', False) -%}
{# BEGIN configs #}
{% set repo = p['configs_repo'] %}
{% if user == 'root' %}
  {% set homedir = '/root' %}
{% else %}
  {% set homedir = '/home/{0}'.format(user) %}
{% endif %}
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

# known_hosts
{% for host, key in p.get('known_hosts', {}).items() %}
user_known_host_{{ host }}:
  ssh_known_hosts.present:
    - user: {{ user }}
    - key: {{ key }}
    - enc: ssh-rsa
    - require:
      - user: user_{{ user}}
{% endfor %}

{# END configs #}
{% endif %}

{% if user == salt_owner %}
{% from 'users/macros.sls' import dirowner %}
/srv/salt:
  file.directory:
    {{ dirowner(user) }}

/srv/pillar:
  file.directory:
    {{ dirowner(user) }}
{% endif %}

{% endfor %}
