{% from "postgres/map.jinja" import version, pkg, encoding, locale with context %}

include:
  - postgres

# drop/create the cluster only if it is not in the target locale yet
{% set current_locale = salt['cmd.run']("psql -Atc 'show lc_ctype'", cwd="/", runas="postgres").strip() %}
{% if current_locale != locale %}

# === WARNING! ===
# This destroys the main cluster!
# Read https://wiki.debian.org/PostgreSql

target_locale:
  locale.present:
    - name: {{ locale }} {{ encoding }}

dropcluster:
  cmd.run:
    - name: pg_dropcluster --stop {{ version }} main
    # let's make sure we have everything we need before killing the cluster
    - require:
      - locale: target_locale
      - pkg: {{ pkg }}

createcluster:
  cmd.run:
    - cwd: /
    - name: pg_createcluster --locale {{ locale }} --start {{ version }} main
    - require:
      - cmd: dropcluster

postgres_up:
  service.running:
    - name: postgresql
    - require:
      - cmd: createcluster
{% endif %}

