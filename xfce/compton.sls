compton:
  pkg.installed

/etc/xdg/compton.conf:
  file.managed:
    - source: salt://xfce/files/compton.conf
    - mode: 644
    - require:
      - pkg: compton

