oracle_vbox_repo:
  pkgrepo.managed:
    - name: deb http://download.virtualbox.org/virtualbox/debian {{ grains['lsb_distrib_codename'] }}
    # contrib section since 4.0 (https://www.virtualbox.org/wiki/Linux_Downloads#Debian-basedLinuxdistributions)
    - comps: contrib
    - file: /etc/apt/sources.list.d/oracle_vbox.list
    {% if grains['osmajorrelease'] > 14 %}
    - key_url: https://www.virtualbox.org/download/oracle_vbox_2016.asc
    {% else %}
    - key_url: http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc
    {% endif %}

vbox_dependencies:
  pkg.installed:
    - pkgs:
      - dkms
      - linux-headers-{{ grains['kernelrelease'] }}

virtualbox-5.1:
  pkg.installed:
    - require:
      - pkgrepo: oracle_vbox_repo
      - pkg: vbox_dependencies

