{% from slspath + "/map.jinja" import runner_name with context %}

include:
  - gitlab.runner
  - docker.engine

# this configures a dind runner, but the executor is still docker,
# so any build step with an image can be run
{{ runner_name }}:
  cmd.run:
    - name: gitlab-runner register --non-interactive
    - unless: gitlab-runner list 2>&1 | grep ^{{ runner_name }}
    - env:
      # see "gitlab-runner register --help"
      - CI_SERVER_URL: {{ pillar['gitlab-runner']['CI_SERVER_URL'] }}
      - REGISTRATION_TOKEN: {{ pillar['gitlab-runner']['REGISTRATION_TOKEN'] }}
      - RUNNER_EXECUTOR: docker
      - RUNNER_NAME: {{ runner_name }}
      - DOCKER_IMAGE: docker:latest
      - DOCKER_PRIVILEGED: true
      - RUNNER_TAG_LIST: {{ grains['id'] }},arm,docker
      - REGISTER_RUN_UNTAGGED: true
    - require:
      - pkg: gitlab-runner
