{% for user, p in pillar.get('users', {}).items() %}
user_{{ user }}:
  group.present:
    - name: {{ user }}
    - gid: {{ p.get('gid', '') }}
    - require_in:
      - user: user_{{ user }}
  user.present:
    - name: {{ user }}
    - fullname: {{ p['name'] }}
    - home: {{ p.get('home', '') }}
    - uid: {{ p.get('uid', '') }}
    - shell: {{ p.get('shell', '') }}
    - groups:
      - {{ user }}
      {% if p.get('admin', False) -%}
      - adm
      - sudo
      {%- endif %}
    - optional_groups:
      {% if p.get('admin', False) -%}
      - cdrom
      - dip
      - lpadmin
      - plugdev
      - sambashare
      - fuse
      - disk
      - docker
      {%- endif %}

{% endfor %}
