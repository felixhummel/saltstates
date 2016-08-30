{% from 'nginx/map.jinja' import dist %}
nginx:
  pkgrepo.absent:
    - name: deb http://nginx.org/packages/ubuntu/ {{ dist }} nginx
    - dist: {{ dist }}
    - file: /etc/apt/sources.list.d/nginx.list
    - key_url: salt://nginx/nginx_signing.key
  pkg.removed: []
  service.dead: []

/etc/nginx/proxy.conf:
  file.absent: []
