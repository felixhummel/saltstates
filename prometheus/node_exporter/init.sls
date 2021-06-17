# https://github.com/prometheus/node_exporter/releases
{% set version='1.1.2' %}
{% set sha256='8c1f6a317457a658e0ae68ad710f6b4098db2cad10204649b51e3c043aa3e70d' %}

node_exporter_tarball_extracted:
  archive.extracted:
    - source: https://github.com/prometheus/node_exporter/releases/download/v{{ version }}/node_exporter-{{ version }}.linux-amd64.tar.gz
    - name: /tmp
    - archive_format: tar
    - source_hash: sha256={{ sha256 }}

/usr/local/bin/node_exporter:
  file.managed:
    - mode: 755
    - source: /tmp/node_exporter-{{ version }}.linux-amd64/node_exporter
    - onchanges:
      - archive: node_exporter_tarball_extracted

/etc/systemd/system/node_exporter.service:
  file.managed:
    - mode: 644
    - source: salt://prometheus/node_exporter/node_exporter.service
    - template: jinja
    - context:
      host: {{ salt['pillar.get']('prometheus:node_exporter:host', '127.0.0.1') }}
      port: {{ salt['pillar.get']('prometheus:node_exporter:port', '9100') }}

node_exporter:
  service.running:
    - enable: True
    - watch:
      - file: /usr/local/bin/node_exporter
      - file: /etc/systemd/system/node_exporter.service
