{% from 'felix/map.jinja' import home with context %}
{% from 'felix/macros.sls' import dirowner %}

include:
  - felix

{{ home }}/.themes:
  file.directory:
    {{ dirowner('felix', recurse=False) }}

github.com:
  ssh_known_hosts.present:
    - user: felix
    - fingerprint: 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48

git@github.com:felixhummel/xfce-AlbatrossFelix.git:
  git.latest:
    - target: {{ home }}/.themes/AlbatrossFelix
    - user: felix
    - require:
      - ssh_known_hosts: github.com
      - file: {{ home }}/.themes

