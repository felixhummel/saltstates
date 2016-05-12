include:
  - users

felix:
  group.present:
    - gid: 1337
    - require_in:
      - user: felix
  user.present:
    - fullname: Felix Hummel
    - home: /home/felix
    - uid: 1337
    - shell: /bin/bash
    - groups:
      - felix
      - adm
      - sudo
    - optional_groups:
      - cdrom
      - dip
      - lpadmin
      - plugdev
      - sambashare
      - fuse
      - disk
      - docker


/home/felix/.gitconfig.d/local:
  file.managed:
    - source: salt://felix/files/gitconfig_local
    - user: felix
    - group: felix
    - mode: 600
    - require:
      - cmd: felix_configs_init

{% for host, key in salt['pillar.get']('users:felix:known_hosts').items() %}
user_known_host_{{ host }}:
  ssh_known_hosts.present:
    - user: felix
    - key: {{ key }}
    - enc: ssh-rsa
    - require:
      - user: felix
{% endfor %}

