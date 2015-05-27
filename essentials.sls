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
      - nmap
      - python-optcomplete
      - rsync
      - tmux
      - tree
      - vim-nox
      - wajig
      - whois

# https://github.com/pypa/pip/issues/1093#issuecomment-103127883
pip_list_fix:
  pkg.purged:
    - name: python-pip
  cmd.script:
    - source: https://bootstrap.pypa.io/get-pip.py
    - unless:
      - pip list >/dev/null
  file.symlink:
    - name: /usr/bin/pip
    - target: /usr/local/bin/pip
    - onchanges:
      - cmd: pip_list_fix
