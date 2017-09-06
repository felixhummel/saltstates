{% set dist = grains['lsb_distrib_codename'] %}

gitlab-ci-multi-runner:
  pkgrepo.managed:
    - name: deb https://packages.gitlab.com/runner/gitlab-ci-multi-runner/ubuntu/ {{ dist }} main
    - dist: {{ dist }}
    - file: /etc/apt/sources.list.d/runner_gitlab-ci-multi-runner.list
    - key_url: salt://gitlab-ci-multi-runner/gpgkey
  pkg.latest: []

gitlab-runner:
  user.present:
    - require:
      - pkg: gitlab-ci-multi-runner
