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
    {% set full_name = p['name'] %}
    {% set email = p['email'] %}
    {% include "users/configs.sls" %}
    {% include "users/gitconfig.sls" %}
  {% endif %}

  {% if user == salt_owner %}
    {% include "users/salt_owner.sls" %}
  {% endif %}

{% endfor %}

