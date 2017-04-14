# https://github.com/prometheus/node_exporter/releases

node_exporter_tarball_extracted:
  archive.extracted:
    - source: https://github.com/prometheus/node_exporter/releases/download/v0.14.0/node_exporter-0.14.0.linux-amd64.tar.gz
    - name: /tmp
    - archive_format: tar
    - source_hash: sha256=d5980bf5d0dc7214741b65d3771f08e6f8311c86531ae21c6ffec1d643549b2e

/usr/local/bin/node_exporter:
  file.managed:
    - mode: 755
    - source: /tmp/node_exporter-0.14.0.linux-amd64/node_exporter
    - require:
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
