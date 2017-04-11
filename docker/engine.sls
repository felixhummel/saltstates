docker_deps:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates

# https://docs.docker.com/engine/installation/linux/ubuntu/#install-using-the-repository
docker_repo:
  pkgrepo.managed:
    - name: deb [arch=amd64] https://download.docker.com/linux/ubuntu {{ grains['oscodename'] }} stable
    - file: /etc/apt/sources.list.d/docker.list
    - key_url: https://download.docker.com/linux/ubuntu/gpg

linux-image-extra-{{ grains['kernelrelease'] }}:
  pkg.installed

docker-ce:
  pkg.installed:
    - require:
      - pkg: docker_deps
      - pkgrepo: docker_repo
      - pkg: linux-image-extra-{{ grains['kernelrelease'] }}

