gitlab-runner:
  pkg.purged: []
  file.absent:
    - name: /etc/apt/sources.list.d/gitlab-runner.list
