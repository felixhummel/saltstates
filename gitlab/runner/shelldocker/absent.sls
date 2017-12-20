{% from slspath + "/map.jinja" import runner_name with context %}

{{ runner_name }}_absent:
  cmd.run:
    - name: gitlab-runner unregister -n {{ runner_name }}
    - onlyif: gitlab-runner list 2>&1 | grep -P '^{{ runner_name }}\s'
