# https://docs.saltstack.com/en/latest/faq.html#what-is-the-best-way-to-restart-a-salt-minion-daemon-using-salt-after-upgrade
Disable starting services:
  file.managed:
    - name: /usr/sbin/policy-rc.d
    - user: root
    - group: root
    - mode: 0755
    - contents:
      - '#!/bin/sh'
      - exit 101
    # do not touch if already exists
    - replace: False
    - prereq:
      - pkg: Upgrade Salt Minion

Upgrade Salt Minion:
  pkg.latest:
    - name: salt-minion
    - order: last

Enable Salt Minion:
  service.enabled:
    - name: salt-minion
    - require:
      - pkg: Upgrade Salt Minion

Enable starting services:
  file.absent:
    - name: /usr/sbin/policy-rc.d
    - onchanges:
      - pkg: Upgrade Salt Minion

Restart Salt Minion:
  cmd.run:
    - name: 'salt-call --local service.restart salt-minion'
    - bg: True
    - onchanges:
      - pkg: Upgrade Salt Minion
