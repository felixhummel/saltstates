include:
  - grub
  - desktop.chrome
  - felix.xfce
  - felix.owns_salt
  - virtualbox
  - private

apps:
  pkg.installed:
    - pkgs:
      - seahorse  # gnome-keyring manager
      - parcellite  # clipboard manager
      - geeqie  # image viewer with treeview - for everything else: ristretto
      - calibre  # ebook-reader
      - cryptsetup
