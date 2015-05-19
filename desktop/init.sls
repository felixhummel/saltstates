# still has the best dev tools as of yet
chromium-browser:
  pkg.installed

kubuntu_ppa:
  pkgrepo.managed:
    - humanname: Kubuntu Backports PPA
    - name: deb http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu utopic main
    - dist: utopic
    - file: /etc/apt/sources.list.d/kubuntu-ppa-ubuntu-backports-utopic.list
    - keyid: 8AC93F7A
    - keyserver: keyserver.ubuntu.com

