# Collection of states for a VM
include:
  - desktop.chrome
  - felix.owns_salt
  - felix.xfce
  - desktop.libreoffice
  - grub
  - private

apps:
  pkg.installed:
    - pkgs:
      - parcellite  # clipboard manager
      - seahorse  # gnome-keyring manager

