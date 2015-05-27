felix:
  group.present:
    - gid: 1337
    - require_in:
      - user: felix
  user.present:
    - fullname: Felix Hummel
    - home: /home/felix
    - uid: 1337
    - shell: /bin/bash
    - groups:
      - felix
      - adm
      - sudo
    - optional_groups:
      - cdrom
      - dip
      - lpadmin
      - plugdev
      - sambashare

# There should be a better way to clean up things here. I guess there is some skeleton, but I'm too lazy to find it now.
{% set dirs = 'Desktop Documents Downloads Music Pictures Public Templates Videos'.split() %}
{% for dir in dirs %}
/home/felix/{{ dir }}:
  file.absent
{% endfor %}

{%- from 'macros.sls' import configs with context -%}
{{ configs('felix') }}

