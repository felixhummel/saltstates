{% set dist = grains['lsb_distrib_codename'] %}
include:
  - apt_transport_https

# https://docs.gitlab.com/runner/install/linux-repository.html
gitlab-runner:
  pkgrepo.managed:
    - name: deb https://packages.gitlab.com/runner/gitlab-runner/ubuntu/ {{ dist }} main
    - dist: {{ dist }}
    - file: /etc/apt/sources.list.d/gitlab-runner.list
    - key_url: https://packages.gitlab.com/runner/gitlab-runner/gpgkey
    - require:
      - pkg: apt_transport_https
  pkg.installed: []
  user.present:
    - require:
      - pkg: gitlab-runner
