include:
  - elastic-beats

filebeat:
  pkg.installed:
    - require:
      - pkgrepo: elastic_beats_repo

