include:
  - known_hosts

https://github.com/felixhummel/xfce-AlbatrossFelix.git:
  git.latest:
    - target: /usr/share/themes/AlbatrossFelix
    - require:
      - ssh_known_hosts: github.com

