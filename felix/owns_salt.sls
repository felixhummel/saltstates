include:
  - felix

/srv/salt:
  file.directory:
    - user: felix
    - group: felix
    - recurse:
        - user
        - group
    - require:
      - user: felix
      - group: felix
/srv/pillar:
  file.directory:
    - user: felix
    - group: felix
    - recurse:
        - user
        - group
    - require:
      - user: felix
      - group: felix
