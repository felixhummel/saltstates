/etc/default/grub:
  file.managed:
    - source: salt://grub/default
    - mode: 644

update-grub:
  cmd.run:
    - onchanges:
      - file: /etc/default/grub
