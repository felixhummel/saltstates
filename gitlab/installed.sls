{% set os = grains['lsb_distrib_id'].lower() %}

include:
  - apt_transport_https

gitlab-ce:
  pkgrepo.managed:
    - name: deb https://packages.gitlab.com/gitlab/gitlab-ce/{{ os }}/ {{ grains['oscodename'] }} main
    - file: /etc/apt/sources.list.d/gitlab.list
    - key_url: https://packages.gitlab.com/gitlab/gitlab-ce/gpgkey
    - require:
      - pkg: apt_transport_https
  pkg.installed: []
