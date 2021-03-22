include:
  - desktop.chrome
  - desktop.libreoffice
  - grub
  - virtualbox
  - xfce.desktop

apps:
  pkg.installed:
    - pkgs:
      - cryptsetup
      - firefox
      - geeqie  # image viewer with treeview - for everything else: ristretto
      - xsel  # parcellite CLI has bugs. xsel works.
      - seahorse  # gnome-keyring manager
      - vlc

