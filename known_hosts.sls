{% for host, key in salt['pillar.get']('known_hosts', {}).items() %}
{{ host }}:
  ssh_known_hosts.present:
    - key: {{ key }}
    - enc: ssh-rsa
{% endfor %}

# also make sure that /etc/ssh/ssh_known_hosts is world-readable
/etc/ssh/ssh_known_hosts:
  file.managed:
    - mode: 644
