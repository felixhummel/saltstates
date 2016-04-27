include:
  - users

# http://askubuntu.com/a/21551
python_build_dependencies:
  pkg.installed:
    - pkgs:
      - build-essential
      - libncursesw5-dev
      - libreadline-gplv2-dev
      - libssl-dev
      - libgdbm-dev
      - libc6-dev
      - libsqlite3-dev
      - tk-dev
      - libbz2-dev

{% for user, p in pillar.get('users', {}).items() %}
{% if p.get('pyenv') %}
{% set home = p.get('home', '/home/{0}'.format(user)) %}
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
