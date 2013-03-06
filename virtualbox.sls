dkms:
  pkg.installed

oracle_vbox:
  pkgrepo.managed:
    - name: deb http://download.virtualbox.org/virtualbox/debian {{ grains['lsb_codename'] }}
    - comps: contrib,non-free
    - file: /etc/apt/sources.list.d/oracle_vbox.list
    - key_url: http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc

