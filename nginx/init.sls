nginx:
  pkg:
    - installed
  service:
    - running
    - onlyif:
      - nginx -t  # better than configtest, because it shows errors

/etc/nginx/proxy.conf:
  file.managed:
    - source: salt://nginx/proxy.conf
    - watch_in:
      - service: nginx

