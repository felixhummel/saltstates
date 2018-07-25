{# e.g. debian or ubuntu #}
{% set distro = grains['lsb_distrib_id'].lower() %}
{# e.g. stretch or xenial #}
{% set codename = grains['lsb_distrib_codename'] %}

include:
  - apt_transport_https

# https://docs.gitlab.com/runner/install/linux-repository.html
gitlab-runner:
  pkgrepo.managed:
    - name: deb https://packages.gitlab.com/runner/gitlab-runner/{{ distro }}/ {{ codename }} main
    - dist: {{ codename }}
    - file: /etc/apt/sources.list.d/runner_gitlab-runner.list
    - key_url: https://packages.gitlab.com/runner/gitlab-runner/gpgkey
    - require:
      - pkg: apt_transport_https
  pkg.installed: []
  user.present:
    - require:
      - pkg: gitlab-runner

/etc/apt/sources.list.d/gitlab-runner.list:
  file.absent
