/etc/default/grub:
  file.managed:
    - source: salt://grub/default
    - template: jinja
    - mode: 644

update-grub:
  cmd.wait:
    - watch:
      - file: /etc/default/grub
