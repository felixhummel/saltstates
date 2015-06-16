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

felix@think:
  ssh_auth.present:
    - user: root
    - source: salt://ssh/think.pub
    - require:
      - file: /root/.ssh
      - pkg: openssh-server

felix@locutus:
  ssh_auth.present:
    - user: root
    - source: salt://ssh/felix@locutus.pub
    - require:
      - file: /root/.ssh
      - pkg: openssh-server

