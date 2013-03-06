oracle_vbox_repo:
  pkgrepo.managed:
    - name: deb http://download.virtualbox.org/virtualbox/debian {{ grains['lsb_codename'] }}
    - comps: contrib,non-free
    - file: /etc/apt/sources.list.d/oracle_vbox.list
    - key_url: http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc

dkms:
  pkg.installed

virtualbox-4.2:
  pkg.installed:
    - require:
      - pkgrepo: oracle_vbox_repo

