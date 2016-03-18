{% from 'felix/macros.sls' import dirowner %}

include:
  - felix

/srv/salt:
  file.directory:
    {{ dirowner('felix') }}

/srv/pillar:
  file.directory:
    {{ dirowner('felix') }}

