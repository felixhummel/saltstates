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
      - nmap
      - pwgen
      - python-optcomplete
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
