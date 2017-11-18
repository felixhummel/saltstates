{% set version = '1.6.2914' %}

#/usr/local/bin/jetbrains-toolbox:
/usr/local/bin:
  archive.extracted:
    - mode: 755
    - source: https://download.jetbrains.com/toolbox/jetbrains-toolbox-{{ version }}.tar.gz
    - source_hash: https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.6.2914.tar.gz.sha256
    - skip_verify: True
    - enforce_toplevel: False
    - options: --strip-components=1

