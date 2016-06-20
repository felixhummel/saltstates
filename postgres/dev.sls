{% from "postgres/map.jinja" import dev_pkg with context %}

postgres_dev_pkg:
  pkg.installed:
    - name: {{ dev_pkg }}

