include:
  - elastic-beats

filebeat:
  pkg.installed:
    - require:
      - pkgrepo: elastic_beats_repo
  file.managed:
    - name: /etc/filebeat/filebeat.yml
    - source: salt://elastic-beats/filebeat.yml
    - require:
      - pkg: filebeat
  service.running:
    - enable: True
    - require:
      - file: filebeat

