{% extends "foo.sls" %}


{% block default_user_stuff %}
{% endblock %}


{% block cleanup_home %}
{% endblock %}


{% block configs %}
{% if p.get('configs_repo', False) %}

{% endif %}
{% endblock %}


{% block salt_owner %}
{% endblock %}

