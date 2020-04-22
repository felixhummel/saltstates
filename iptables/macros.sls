{#
in the NAT world, always think of socket pairs that result in a 4-tuple [1]:

(source_ip, source_port, destination ip, destination_port)

Example: a client on CLIENT_IP with CLIENT_PORT connects via HTTPS to this
server's PUBLIC_IP:

(CLIENT_IP, CLIENT_PORT, PUBLIC_IP, HTTPS)

We want to forward HTTPS to VM_IP.
#}

{# forward specific ports to a guest #}
{# ================================= #}
{% macro forward_ports(interface, src_ip, dst_ip, ports) %}

{% for port in ports %}

  {#
  forward (DNAT) incoming packets to another machine, i.e.

  (CLIENT_IP, CLIENT_PORT, PUBLIC_IP, HTTPS)
  -->
  (CLIENT_IP, CLIENT_PORT, VM_IP, HTTPS)

  allow those connections (ACCEPT)
  #}
dnat_port_{{ port }}_from_{{ src_ip }}_to_{{ dst_ip }}:
  iptables.insert:
    - position: 1
    - table: nat
    - chain: PREROUTING
    - protocol: tcp
    - destination: {{ src_ip }}
    - dport: {{ port }}
    - in-interface: {{ interface }}
    - jump: DNAT
    - to: {{ dst_ip }}:{{ port }}
    - save: True
    #- comment: salted
  {#
  set the "source IP", i.e. do SNAT, because
  others need to see our host's IP.

  This time the tuple has the order (<vm ip/port>, <client ip/port>).

  (VM_IP, HTTPS, CLIENT_IP, CLIENT_PORT)
  -->
  (PUBLIC_IP, HTTPS, CLIENT_IP, CLIENT_PORT)

  man iptables-extensions
  #}
snat_{{ dst_ip }}_on_{{ port }}_to_{{ src_ip }}_on_{{ interface }}:
  iptables.insert:
    - table: nat
    - chain: POSTROUTING
    - protocol: tcp
    - position: 1
    - source: {{ dst_ip }}
    - sport: {{ port }}
    - out-interface: {{ interface }}
    - jump: SNAT
    - to-source: {{ src_ip }}
    - save: True
    #- comment: salted

accept_forwards_to_{{ dst_ip }}_on_{{ port }}:
  iptables.insert:
    - position: 1
    - table: filter
    - chain: FORWARD
    - protocol: tcp
    - destination: {{ dst_ip }}
    - dport: {{ port }}
    - in-interface: {{ interface }}
    - jump: ACCEPT
    - save: True
    - comment: salted

{% endfor %}

{% endmacro %}


{# forward an external ip completely to a guest #}
{# ============================================ #}
{% macro forward_ip(guest_name, external_ip, internal_ip) %}

dnat_{{ guest_name }}:
  iptables.insert:
    - table: nat
    - chain: PREROUTING
    - position: 1
    - destination: {{ external_ip }}
    - jump: DNAT
    - to: {{ internal_ip }}
    - save: True
    - comment: {{ guest_name }}
snat_{{ guest_name }}:
  iptables.insert:
    - table: nat
    - chain: POSTROUTING
    - position: 1
    - source: {{ internal_ip }}
    - jump: SNAT
    - to-source: {{ external_ip }}
    - save: True
    - comment: {{ guest_name }}

accept_{{ guest_name }}:
  iptables.insert:
    - table: filter
    - chain: FORWARD
    - position: 1
    - destination: {{ internal_ip }}
    - jump: ACCEPT
    - save: True
    - comment: {{ guest_name }}

{% endmacro %}

{#
[1] https://en.wikipedia.org/wiki/Network_socket#Socket_pairs
[2] https://stackoverflow.com/a/15763717/241240
[3] https://www.digitalocean.com/community/tutorials/a-deep-dive-into-iptables-and-netfilter-architecture

Trivia: TCP connections can be described with 5-tuples that contain the
protocol too [2].
#}

