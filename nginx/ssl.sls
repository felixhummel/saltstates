{% set dhparam = '/etc/ssl/dhparam.pem' %}
include:
  - nginx

{{ dhparam }}:
  cmd.run:
    - name: openssl dhparam -out {{ dhparam }} 2048
    - unless: openssl dhparam -in {{ dhparam }} -text | grep -q '2048 bit'

/etc/nginx/ssl.conf:
  file.managed:
    - source: salt://nginx/ssl.conf
    - require:
      - cmd: {{ dhparam }}
