felix:
  group.present:
    - gid: 1337
    - require_in:
      - user: felix
  user.present:
    - fullname: Felix Hummel
    - home: /home/felix
    - uid: 1337
    - groups:
      - felix
      - adm
      - cdrom
      - dip
      - lpadmin
      - plugdev
      - sambashare
      - sudo

