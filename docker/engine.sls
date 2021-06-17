{# e.g. debian or ubuntu #}
{% set distro = grains['lsb_distrib_id'].lower() %}
{# e.g. stretch or xenial #}
{% set codename = grains['lsb_distrib_codename'] %}
{# AWS kernel already contains extra modules #}
{% set is_aws = 'aws' in grains['kernelrelease'] %}
{%- if distro == 'bionic' %}
  {% set linux_extra = 'linux-modules-extra-' + grains['kernelrelease'] %}
{%- else %}
  {% set linux_extra = 'linux-image-extra-' + grains['kernelrelease'] %}
{%- endif %}
{% set need_linux_image_extra = (not is_aws and distro == 'ubuntu' and grains['osmajorrelease'] < 20) %}

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
    - key_url: https://download.docker.com/linux/{{ distro }}/gpg

{%- if need_linux_image_extra %}
{{ linux_extra }}:
  pkg.installed
{%- endif %}

docker-ce:
  pkg.installed:
    - require:
      - pkg: docker_deps
      - pkgrepo: docker_repo

{%- if need_linux_image_extra %}
      - pkg: {{ linux_extra }}
{%- endif %}

docker:
  service.running
