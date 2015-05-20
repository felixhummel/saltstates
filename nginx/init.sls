libssl1.0.0:  # heartbleed
  pkg.latest


nginx:
  pkgrepo.managed:
    - name: deb http://nginx.org/packages/ubuntu/ {{ grains['lsb_distrib_codename'] }} nginx
    - dist: {{ grains['lsb_distrib_codename'] }}
    - file: /etc/apt/sources.list.d/nginx.list
    - key_url: salt://nginx/nginx_signing.key
  pkg.latest: []
  service.running:
    - onlyif:
      - nginx -t  # better than configtest, because it shows errors

/etc/nginx/proxy.conf:
  file.managed:
    - source: salt://nginx/proxy.conf
    - watch_in:
      - service: nginx

