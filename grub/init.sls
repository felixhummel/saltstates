/etc/default/grub:
  file.managed:
    - source: salt://grub/default
    - mode: 644

