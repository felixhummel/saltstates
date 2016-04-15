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

