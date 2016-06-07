include:
  - ntp

tools:
  pkg.installed:
    - pkgs:
      - atool
      - bash-completion
      - curl
      - dnsutils
      - gpm
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
      # https://docs.saltstack.com/en/latest/ref/states/all/salt.states.pkgrepo.html
      - python-software-properties
      - python-virtualenv
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
