include:
  - desktop.chrome
  - desktop.libreoffice
  - grub
  - private
  - virtualbox
  - xfce.desktop
  - xfce.compton

apps:
  pkg.installed:
    - pkgs:
      - calibre  # ebook-reader
      - cryptsetup
      - firefox
      - geeqie  # image viewer with treeview - for everything else: ristretto
      - parcellite  # clipboard manager
      - xsel  # parcellite CLI has bugs. xsel works.
      - seahorse  # gnome-keyring manager
      - vlc

