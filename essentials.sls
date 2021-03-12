tools:
  pkg.installed:
    - pkgs:
      - atool
      - bash-completion
      - curl
      - dnsutils
      - htop
      - inotify-tools
      - iotop
      - jnettop
      - lftp
      - lsof
      - ncdu
      - net-tools  # netstat
      - nmap
      - pwgen
{%- if grains['osrelease'] != '20.04' %}
      - python-optcomplete
{%- endif %}
      - rsync
      - tmux
      - tofrodos
      - tree
      - vim-nox
      - wajig
      - whois

{% if grains['osrelease'] == '14.04' %}
git_ppa:
  pkgrepo.managed:
    - ppa: git-core/ppa
{% endif %}
