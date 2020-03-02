minimal-xubuntu-packages:
  pkg.installed:
    - pkgs:
      - xubuntu-core:
      - mousepad
      - menulibre  # to edit whisker menu
      - xfce4-netload-plugin  # panel: net
      - xfce4-systemload-plugin  # panel: cpu, mem, swap
      - xfce4-fsguard-plugin  # panel: disk space
