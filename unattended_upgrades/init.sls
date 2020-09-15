# https://wiki.debian.org/UnattendedUpgrades
unattended_upgrades_packages:
  pkg.installed:
    - pkgs:
      - unattended-upgrades
      - apt-listchanges
      - debconf-utils  # for salt's debconfmod


enable_unattended_upgrades:
  debconf.set:
    - name: unattended-upgrades
    - data:
        'unattended-upgrades/enable_auto_updates': {'type': 'boolean', 'value': 'true'}


# configure unattended upgrades
/etc/apt/apt.conf.d/50unattended-upgrades:
  file.managed:
    - source: salt://unattended_upgrades/files/50unattended-upgrades
    - mode: 644
    - template: jinja
    - require:
      - pkg: unattended_upgrades_packages
