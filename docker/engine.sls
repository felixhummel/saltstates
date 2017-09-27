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

# use overlay2 (instead of aufs)
# https://docs.docker.com/engine/userguide/storagedriver/overlayfs-driver/#configure-docker-with-the-overlay-or-overlay2-storage-driver
/etc/docker/daemon.json:
  file.managed:
    - source: salt://docker/files/daemon.json
    - mode: 600

docker:
  service.running:
    - watch:
      - file: /etc/docker/daemon.json
