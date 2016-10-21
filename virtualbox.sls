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

virtualbox:
  pkg.installed:
    - name: virtualbox-5.1
    - require:
      - pkgrepo: oracle_vbox_repo
      - pkg: vbox_dependencies

{% set url = 'http://download.virtualbox.org/virtualbox/5.1.8/Oracle_VM_VirtualBox_Extension_Pack-5.1.8-111374.vbox-extpack' %}
{% set hash_url = 'https://www.virtualbox.org/download/hashes/5.1.8/SHA256SUMS' %}
{% set filename = url.split('/')[-1] %}
{% set path = '/var/tmp/%s' % filename %}
extpack_file:
  file.managed:
    - name: {{ path }}
    - source: {{ url }}
    - source_hash: {{ hash_url }}

extpack_install:
  cmd.run:
    - name: vboxmanage extpack install {{ path }}
    - unless: "vboxmanage list extpacks | grep 'Oracle VM VirtualBox Extension Pack'"
    - require:
      - pkg: virtualbox
      - file: extpack_file

