include:
  - .

gitlab-runner verify --delete:
  cmd.run:
    - require:
      - pkg: gitlab-runner
