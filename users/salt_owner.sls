{% from 'users/macros.sls' import dirowner %}
/srv/salt:
  file.directory:
    {{ dirowner(user) }}

/srv/pillar:
  file.directory:
    {{ dirowner(user) }}

