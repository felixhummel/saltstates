      {% set extra_groups = p.get('extra_groups', []) %}
user_{{ user }}:
  group.present:
    - name: {{ user }}
    - gid: {{ p.get('gid', '') }}
    - require_in:
      - user: user_{{ user }}
  user.present:
    - name: {{ user }}
    - fullname: {{ p['name'] }}
    - uid: {{ p.get('uid', '') }}
    - password: {{ p.get('password_hash', '') }}
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
      {% for g in extra_groups %}
      - {{ g }}
      {%- endfor %}

