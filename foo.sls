{% from 'users/macros.sls' import gethomedir %}
{% set salt_owner = pillar.get('salt_owner', None) %}

{% for user, p in pillar.get('users', {}).items() %}

  {% set homedir = gethomedir(user) %}

  {% block default_user_stuff scoped %}{% endblock %}

  {% if p.get('cleanup_home', False) %}
    {% block cleanup_home scoped %}{% endblock %}
  {% endif %}

  {% if p.get('configs_repo', False) %}
    {% block configs scoped %}{% endblock %}
  {% endif %}

  {% if user == salt_owner %}
    {% block salt_owner scoped %}{% endblock %}
  {% endif %}

{% endfor %}

