# I had problems with xfce4's light locker. This state replaces it with
# xscreensaver. Thanks go to https://askubuntu.com/a/511212
lightlocker_purged:
  pkg.purged:
    - pkgs:
      - light-locker
      - light-locker-settings

xscreensaver:
  pkg.installed:
    - require:
      - pkg: lightlocker_purged
