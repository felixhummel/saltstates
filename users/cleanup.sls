# There should be a better way to clean up things here. I guess there is
# some skeleton, but I'm too lazy to find it now.
{% set dirs = 'Documents Music Pictures Public Templates Videos'.split() %}
{% for dir in dirs %}
/home/{{ user }}/{{ dir }}:
  file.absent:
    - require:
      - user: user_{{ user }}
{% endfor %}

