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

# There should be a better way to clean up things here. I guess there is some skeleton, but I'm too lazy to find it now.
{% set dirs = 'Desktop Documents Downloads Music Pictures Public Templates Videos'.split() %}
{% for dir in dirs %}
/home/felix/{{ dir }}:
  file.absent
{% endfor %}

# this basically f***s up the remote, just to fix it afterwards
# and get a good return code from "git config"
# This should be fixed in the git state, but I'm too lazy today to file
# a proper issue. :/
# See also https://github.com/saltstack/salt/issues/12750
# For future reference:
# # git --version 
# git version 2.1.0
# # salt-call --version
# salt-call 2014.7.1 (Helium)
git config branch.master.remote foo:
  cmd.run:
    - cwd: /home/felix/configs
    - user: felix
    - group: felix
    - require_in:
      - https://github.com/felixhummel/configs.git


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
