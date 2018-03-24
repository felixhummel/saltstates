# https://wiki.debian.org/UnattendedUpgrades
unattended_upgrades_packages:
  pkg.installed:
    - pkgs:
      - unattended-upgrades
      - apt-listchanges

/etc/apt/apt.conf.d/50unattended-upgrades:
  file.managed:
    - source: salt://unattended_upgrades/files/50unattended-upgrades
    - mode: 644
    - template: jinja
    - require:
      - pkg: unattended_upgrades_packages
