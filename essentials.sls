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

