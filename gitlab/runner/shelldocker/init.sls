{% from slspath + "/map.jinja" import runner_name with context %}

include:
  - gitlab.runner
  - docker.engine
  - docker.compose

gitlab_runner_in_docker_group:
  user.present:
    - name: gitlab-runner
    - optional_groups:
      - docker
    - require:
      - pkg: gitlab-runner

{{ runner_name }}:
  cmd.run:
    - name: gitlab-runner register --non-interactive
    - unless: gitlab-runner list 2>&1 | grep ^{{ runner_name }}
    - env:
      # see "gitlab-runner register --help"
      - CI_SERVER_URL: {{ pillar['gitlab-runner']['CI_SERVER_URL'] }}
      - REGISTRATION_TOKEN: {{ pillar['gitlab-runner']['REGISTRATION_TOKEN'] }}
      - RUNNER_EXECUTOR: shell
      - RUNNER_NAME: {{ runner_name }}
      - RUNNER_TAG_LIST: {{ grains['id'] }},shelldocker
      - REGISTER_RUN_UNTAGGED: {{ pillar.get('gitlab-runner:REGISTER_RUN_UNTAGGED', 'true') }}
      - REGISTER_LOCKED: "false"
    - require:
      - pkg: gitlab-runner
      - user: gitlab_runner_in_docker_group

# https://docs.gitlab.com/runner/shells/index.html#shell-profile-loading
/home/gitlab-runner/.bash_logout:
  file.absent:
    - require:
      - user: gitlab-runner
