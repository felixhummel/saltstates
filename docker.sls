docker_deps:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates

docker_repo:
  pkgrepo.managed:
    - name: deb https://apt.dockerproject.org/repo ubuntu-{{ grains['oscodename'] }} main
    - file: /etc/apt/sources.list.d/docker.list
    - keyid: 58118E89F3A912897C070ADBF76221572C52609D
    - keyserver: hkp://p80.pool.sks-keyservers.net:80

linux-image-extra-{{ grains['kernelrelease'] }}:
  pkg.installed

docker-engine:
  pkg.installed:
    - require:
      - pkg: docker_deps
      - pkgrepo: docker_repo
      - pkg: linux-image-extra-{{ grains['kernelrelease'] }}

# https://docs.docker.com/compose/install/
# https://github.com/docker/compose/releases
/usr/local/bin/docker-compose:
  file.managed:
    - mode: 755
    - source: https://github.com/docker/compose/releases/download/1.11.1/docker-compose-{{ grains['kernel'] }}-{{ grains['cpuarch'] }}
    - skip_verify: True

# Salt needs this to manage containers
docker-py:
  pip.installed

