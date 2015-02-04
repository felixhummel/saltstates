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
      - cdrom
      - dip
      - lpadmin
      - plugdev
      - sambashare
      - sudo

# There should be a better way to clean up things here. I guess there is some skeleton, but I'm too lazy to find it now.
{% set dirs = 'Desktop Documents Downloads Music Pictures Public Templates Videos'.split() %}
{% for dir in dirs %}
/home/felix/{{ dir }}:
  file.absent
{% endfor %}

https://github.com/felixhummel/configs.git:
  git.latest:
    - rev: master
    - target: /home/felix/configs
    - user: felix
    - submodules: True
    - require:
      - user: felix

./init --force:
  cmd.run:
    - cwd: /home/felix/configs
    - user: felix
    - group: felix
    - watch:
      - git: https://github.com/felixhummel/configs.git
