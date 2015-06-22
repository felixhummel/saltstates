{% from "iptables/map.jinja" import open_ports, allow_icmp with context %}
# http://joshrendek.com/2013/01/securing-ubuntu/#iptables_rules
iptables_allow_established_connections:
  iptables.append:
    - table: filter
    - chain: INPUT
    - match: state
    - connstate: ESTABLISHED,RELATED
    - jump: ACCEPT

iptables_allow_outbound_connections:
  iptables.append:
    - table: filter
    - chain: OUTPUT
    - jump: ACCEPT

{% for port in open_ports %}
iptables_allow_{{ port }}:
  iptables.append:
    - table: filter
    - chain: INPUT
    - proto: tcp
    - dport: {{ port }}
    - jump: ACCEPT
{% endfor %}

{% if allow_icmp %}
iptables_allow_icmp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - proto: icmp
    - match: icmp
    - icmp-type: 8
    - jump: ACCEPT
{% endif %}

iptables_log_denied:
  iptables.append:
    - table: filter
    - chain: INPUT
    - match: limit
    - limit: 5/min
    - jump: 'LOG --log-prefix "iptables denied: " --log-level 7'

# REJECT instead of DROP, because it's nicer and nmap is fast no matter what.
# http://unix.stackexchange.com/a/109462/120440
# Policy requires a "target". Append also takes a "target extension" like
# REJECT.
# http://unix.stackexchange.com/a/46031/120440
iptables_drop_input:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: REJECT

iptables_drop_forward:
  iptables.append:
    - table: filter
    - chain: FORWARD
    - jump: REJECT
