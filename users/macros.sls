{% macro dirowner(name, recurse=True) %}
    - user: {{ name }}
    - group: {{ name }}
    {% if recurse %}
    - recurse:
        - user
        - group
    {% endif %}
    - require:
      - user: {{ name }}
      - group: {{ name }}
{% endmacro %}

{% macro gethomedir(username) -%}
{% if username == 'root' -%}
/root
{%- else -%}
/home/{{ username }}
{%- endif %}
{%- endmacro %}
