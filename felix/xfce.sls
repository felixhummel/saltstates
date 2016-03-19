{% from 'felix/map.jinja' import home with context %}
{% from 'felix/macros.sls' import dirowner %}

include:
  - felix

{{ home }}/.themes:
  file.directory:
    {{ dirowner('felix', recurse=False) }}

git@github.com:felixhummel/xfce-AlbatrossFelix.git:
  git.latest:
    - target: {{ home }}/.themes/AlbatrossFelix
    - user: felix
    - require:
      - ssh_known_hosts: github.com
      - file: {{ home }}/.themes

