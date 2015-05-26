include:
  - .chrome
  - .dropbox
  - .ipython
  - .krusader

kubuntu_backports:
  pkgrepo.managed:
    - humanname: Kubuntu Backports PPA
    - name: deb http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu {{ grains['oscodename'] }} main
    - dist: {{ grains['oscodename'] }}
    - file: /etc/apt/sources.list.d/kubuntu-backports-ppa.list
    - keyid: 8AC93F7A
    - keyserver: keyserver.ubuntu.com

