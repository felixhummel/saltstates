{% set dist = grains['lsb_distrib_codename'] %}

# see https://nodejs.org/en/download/package-manager/
nodejs:
  pkgrepo.managed:
    - name: deb https://deb.nodesource.com/node_6.x {{ dist }} main
    - dist: {{ dist }}
    - file: /etc/apt/sources.list.d/nodesource.list
    - key_url: https://deb.nodesource.com/gpgkey/nodesource.gpg.key
  pkg.installed: []

# to build extensions when installing from npm
build_tools_for_node:
  pkg.installed:
    - name: build-essential

