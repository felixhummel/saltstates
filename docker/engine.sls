{% set is_aws = 'aws' in grains['kernelrelease'] %}
{%- if grains['lsb_distrib_codename'] == 'bionic' %}
  {% set linux_extra = 'linux-modules-extra-' + grains['kernelrelease'] %}
{%- else %}
  {% set linux_extra = 'linux-image-extra-' + grains['kernelrelease'] %}
{%- endif %}
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

{# aws image contains kernel extra modules #}
{%- if not is_aws %}
{{ linux_extra }}:
  pkg.installed
{%- endif %}

docker-ce:
  pkg.installed:
    - require:
      - pkg: docker_deps
      - pkgrepo: docker_repo
{%- if not is_aws %}
    - pkg: {{ linux_extra }}
{%- endif %}

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
