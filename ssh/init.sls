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

felix@think:
  ssh_auth.present:
    - user: felix
    - source: salt://ssh/think.pub
    - require:
      - file: /home/felix/.ssh
      - pkg: openssh-server

