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

