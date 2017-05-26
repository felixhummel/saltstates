include:
  - pip

# Salt needs this to manage containers
docker-py:
  pip.installed:
    - name: docker
    - require:
      - pkg: pip

