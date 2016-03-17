/etc/default/grub:
  file.managed:
    - source: salt://grub/default
    - mode: 644

update-grub:
  cmd.wait:
    - watch:
      - file: /etc/default/grub
