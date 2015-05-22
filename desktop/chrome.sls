libappindicator1:
  pkg.installed
google-chrome-stable:
  pkg.installed:
    - sources:
      - google-chrome-stable: https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    - require:
      - pkg: libappindicator1

