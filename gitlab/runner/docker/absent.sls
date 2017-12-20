{% from "gitlab/runner/docker/map.jinja" import runner_name with context %}

{{ runner_name }}:
  cmd.run:
    - name: gitlab-ci-multi-runner unregister -n {{ runner_name }}
    - onlyif: gitlab-runner list 2>&1 | grep -P '^{{ runner_name }}\s'
