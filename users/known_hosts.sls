{% for host, key in p.get('known_hosts', {}).items() %}
{{ user }}_known_host_{{ host }}:
  ssh_known_hosts.present:
    - user: {{ user }}
    - key: {{ key }}
    - enc: ssh-rsa
    - require:
      - user: user_{{ user}}
{% endfor %}


