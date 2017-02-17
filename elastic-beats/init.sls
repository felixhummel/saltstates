# https://www.elastic.co/guide/en/beats/libbeat/5.2/setup-repositories.html

elastic_beats_deps:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates

elastic_beats_repo:
  pkgrepo.managed:
    - name: deb https://artifacts.elastic.co/packages/5.x/apt stable main
    - file: /etc/apt/sources.list.d/elastic_beats.list
    - key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch


