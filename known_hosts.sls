{% for host, key in salt['pillar.get']('known_hosts', {}).items() %}
{{ host }}:
  ssh_known_hosts.present:
    - key: {{ key }}
    - enc: ssh-rsa
{% endfor %}
