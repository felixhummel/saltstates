include:
  - apt_transport_https

gitlab-ce:
  pkgrepo.managed:
    - name: deb https://packages.gitlab.com/gitlab/gitlab-ce/ubuntu/ {{ grains['oscodename'] }} main
    - file: /etc/apt/sources.list.d/gitlab.list
    - key_url: https://packages.gitlab.com/gpg.key
    - require:
      - pkg: apt_transport_https
  pkg.installed: []

