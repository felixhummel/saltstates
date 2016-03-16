openssh-server:
  pkg.latest

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://ssh/sshd_config
    - require:
      - pkg: openssh-server

ssh:
  service.running:
    - watch:
      - file: /etc/ssh/sshd_config

fail2ban:
  pkg.latest

/root/.ssh:
  file.directory:
    - user: root
    - group: root
    - mode: 700

