include:
  - .ipython
# still has the best dev tools as of yet
chromium-browser:
  pkg.installed

# newer than chromium. best dev tools
libappindicator1:
  pkg.installed
google-chrome-stable:
  pkg.installed:
    - sources:
      - google-chrome-stable: https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    - require:
      - pkg: libappindicator1

kubuntu_ppa:
  pkgrepo.managed:
    - humanname: Kubuntu Backports PPA
    - name: deb http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu utopic main
    - dist: utopic
    - file: /etc/apt/sources.list.d/kubuntu-ppa-ubuntu-backports-utopic.list
    - keyid: 8AC93F7A
    - keyserver: keyserver.ubuntu.com

krusader:
  pkg.installed:
    - pkgs:
      - krusader
      - krename
      - kdiff3

