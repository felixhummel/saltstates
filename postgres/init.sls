{% from "postgres/map.jinja" import version, pkg, encoding, users, locale with context %}

{{ pkg }}:
  pkgrepo.managed:
    - name: deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main
    - dist: trusty-pgdg
    - file: /etc/apt/sources.list.d/pgdg.list
    - key_url: https://www.postgresql.org/media/keys/ACCC4CF8.asc
    - require_in:
      - pkg: {{ pkg }}
  pkg.installed:
    - name: {{ pkg }}

pg_hba.conf:
  file.managed:
    - name: /etc/postgresql/9.4/main/pg_hba.conf
    - source: salt://postgres/pg_hba.conf
postgresql.conf:
  file.managed:
    - name: /etc/postgresql/9.4/main/postgresql.conf
    - source: salt://postgres/postgresql.conf
    - template: jinja
    - context:
      locale: {{ locale }}

postgres_service:
  service.running:
    - name: postgresql
    - watch:
      - file: pg_hba.conf
      - file: postgresql.conf

{% for user in users %}
{% set stateid = 'postgres_user_%s' % user %}
{{ stateid }}:
  postgres_user.present:
    - name: {{ user }}
    - require:
      - pkg: {{ pkg }}

  postgres_database.present:
    - name: {{ user }}
    - owner: {{ user }}
    - require:
      - postgres_user: {{ stateid }}
{% endfor %}


