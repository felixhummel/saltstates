{% from 'ntp/map.jinja' import ntp_servers %}
ntp:
  pkg.installed: []
  service.running:
    - watch:
      - file: /etc/ntp.conf

/etc/ntp.conf:
  file.managed:
    - source: salt://ntp/files/ntp.conf
    - mode: 644
    - template: jinja
    - context:
      ntp_servers: {{ ntp_servers }}

