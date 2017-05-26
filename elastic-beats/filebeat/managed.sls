include:
  - elastic-beats.filebeat

/etc/filebeat/filebeat.yml:
  file.managed:
    - name: 
    - source: salt://elastic-beats/filebeat/filebeat.yml
    - require:
      - pkg: filebeat
    - watch_in:
      - service: filebeat

