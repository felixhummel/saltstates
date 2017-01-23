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
    - source: https://github.com/docker/compose/releases/download/1.9.0/docker-compose-{{ grains['kernel'] }}-{{ grains['cpuarch'] }}
    - source_hash: sha512=4a44b4035f321ee2089ca1265a2f853b6a678ccbb18f0de91f5d9aef80dfbdc23b1598f13e8db0149b36417e561ca8ae748b7c7a9c7bf1ae97549cef7628bb7d

# Salt needs this to manage containers
docker-py:
  pip.installed

