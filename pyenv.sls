{% from 'users/macros.sls' import gethomedir %}
include:
  - users

python_build_dependencies:
  pkg.installed:
    - pkgs:
      # https://github.com/pyenv/pyenv/wiki/common-build-problems
      - build-essential
      - curl
      - git
      - libbz2-dev
      - libffi-dev
      - liblzma-dev
      - libncurses5-dev
      - libncursesw5-dev
      - libreadline-dev
      - libsqlite3-dev
      - libssl-dev
      - llvm
      - make
      - python-openssl
      - tk-dev
      - wget
      - xz-utils
      - zlib1g-dev

{% for user, p in pillar.get('users', {}).items() %}
{% if p.get('pyenv') %}
{% set home = gethomedir(user) %}
pyenv_for_{{ user }}:
  git.latest:
    - name: https://github.com/yyuu/pyenv.git
    - target: {{ home }}/.pyenv
    - user: {{ user }}
    - require:
      - user: user_{{ user }}
pyenv_virtualenv_for_{{ user }}:
  git.latest:
    - name: https://github.com/yyuu/pyenv-virtualenv.git
    - target: {{ home }}/.pyenv/plugins/pyenv-virtualenv
    - user: {{ user }}
    - require:
      - user: user_{{ user }}
{% endif %}
{% endfor %}
