include:
  - nginx

/etc/nginx/conf.d/default.conf:
  file.managed:
    - source: salt://nginx/sites/default/conf
    - template: jinja
    - watch_in:
      - service: nginx

{{ grains['fqdn'] }}:
  host.present:
    - ip: 127.0.0.1


