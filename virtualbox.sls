oracle_vbox_repo:
  pkgrepo.managed:
    - name: deb http://download.virtualbox.org/virtualbox/debian {{ grains['lsb_distrib_codename'] }}
    # contrib section since 4.0 (https://www.virtualbox.org/wiki/Linux_Downloads#Debian-basedLinuxdistributions)
    - comps: contrib
    - file: /etc/apt/sources.list.d/oracle_vbox.list
    - key_url: http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc

dkms:
  pkg.installed

virtualbox:
  pkg.installed:
    - require:
      - pkgrepo: oracle_vbox_repo

