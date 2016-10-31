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
/usr/local/bin/docker-compose:
  file.managed:
    - mode: 755
    - source: https://github.com/docker/compose/releases/download/1.8.1/docker-compose-{{ grains['kernel'] }}-{{ grains['cpuarch'] }}
    - source_hash: sha512=7131cd0f9bad2e6f7f2369c6c9ed353127e6b63209edb5d0f4491c065cdffce274267d1eceb6eefc36169d593785a7d1612d1061c110b75eb2ab2482af7ebf08
