{% macro configs(user) %}
configs_repo:
  git.latest:
    - name: https://github.com/felixhummel/configs.git
    - rev: master
    - target: /home/{{ user }}/configs
    - user: {{ user }}
    - submodules: True
    - require:
      - user: {{ user }}

init_configs:
  cmd.run:
    - name: ./init --force --skip-git
    - cwd: /home/{{ user }}/configs
    - user: {{ user }}
    - group: {{ user }}
    - prereq:
      - git: configs_repo
{% endmacro %}
