{% set version = '1.17.0' %}
# https://docs.docker.com/compose/install/
# https://github.com/docker/compose/releases
/usr/local/bin/docker-compose:
  file.managed:
    - mode: 755
    - source: https://github.com/docker/compose/releases/download/{{ version }}/docker-compose-{{ grains['kernel'] }}-{{ grains['cpuarch'] }}
    - skip_verify: True
    - unless: docker-compose --version | grep {{ version }}

