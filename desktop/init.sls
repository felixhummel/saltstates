include:
  - desktop.chrome
  - felix.owns_salt
  - felix.xfce
  - desktop.libreoffice
  - grub
  - private
  - virtualbox

apps:
  pkg.installed:
    - pkgs:
      - calibre  # ebook-reader
      - cryptsetup
      - geeqie  # image viewer with treeview - for everything else: ristretto
      - parcellite  # clipboard manager
      - seahorse  # gnome-keyring manager
      - vlc
