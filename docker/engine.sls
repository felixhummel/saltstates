{# e.g. debian or ubuntu #}
{% set distro = grains['lsb_distrib_id'].lower() %}
{# e.g. stretch or xenial #}
{% set codename = grains['lsb_distrib_codename'] %}
{% set need_linux_image_extra = (distro == 'ubuntu' and not 'aws' in grains['kernelrelease']) %}
docker_deps:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates

# https://docs.docker.com/engine/installation/linux/ubuntu/#install-using-the-repository
docker_repo:
  pkgrepo.managed:
    - name: deb [arch=amd64] https://download.docker.com/linux/{{ distro }} {{ codename }} stable
    - file: /etc/apt/sources.list.d/docker.list
    - key_url: https://download.docker.com/linux/ubuntu/gpg

{# aws image contains kernel extra modules #}
{%- if need_linux_image_extra %}
linux-image-extra-{{ grains['kernelrelease'] }}:
  pkg.installed
{%- endif %}

docker-ce:
  pkg.installed:
    - require:
      - pkg: docker_deps
      - pkgrepo: docker_repo
{%- if need_linux_image_extra %}
      - pkg: linux-image-extra-{{ grains['kernelrelease'] }}
{%- endif %}

docker:
  service.running
