{% from 'users/macros.sls' import gethomedir %}
{% set salt_owner = pillar.get('salt_owner', None) %}

{% for user, p in pillar.get('users', {}).items() %}

  {%- set homedir = gethomedir(user) -%}

  {% include "users/user_and_group.sls" %}
  {% include "users/known_hosts.sls" %}

  {% if p.get('cleanup_home', False) %}
    {% include "users/cleanup.sls" %}
  {% endif %}

  {% if p.get('configs_repo', False) %}
    {% set repo = p['configs_repo'] %}
    {% include "users/configs.sls" %}
  {% endif %}

  {% if user == salt_owner %}
    {% include "users/salt_owner.sls" %}
  {% endif %}

{% endfor %}

