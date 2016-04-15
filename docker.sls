docker_deps:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates

docker_repo:
  pkgrepo.managed:
    - name: deb https://apt.dockerproject.org/repo ubuntu-{{ grains['oscodename'] }} main
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
    - source: https://github.com/docker/compose/releases/download/1.7.0/docker-compose-{{ grains['kernel'] }}-{{ grains['cpuarch'] }}
    - source_hash: sha512=ebb70b96961c18d3cbdd045e742087a018ea3d20d223f7e23cdace0bd77a596bf68952d767b79c1dfada35123dfcc7f2dd3a1a6dc8134f8d5cf7e445665061b2
