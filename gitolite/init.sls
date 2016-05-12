{% set username = 'g' %}
{% set home = salt['file.join']('/home', username') %}
{% set bindir = salt['file.join'](home, 'bin') %}

{{ username }}:
  user.present:
    - system: True
    - fullname: private git
    - home: {{ home }}
    - shell: /bin/bash

gitolite_admin_pubkey:
  file.managed:
    - name: {{ home }}/felix@locutus.pub
    - source: salt://ssh/felix@locutus.pub
    - user: {{ username }}
    - group: {{ username }}
    - mode: 600
    - require:
      - user: {{ username }}

gitolite_bin_dir:
  file.directory:
    - name: {{ bindir }}
    - user: {{ username }}
    - group: {{ username }}
    - mode: 700
    - require:
      - user: {{ username }}

gitolite_repo:
  git.latest:
    - name: https://github.com/sitaramc/gitolite.git
    - rev: master
    - target: {{ home }}/gitolite
    - user: {{ username }}
    - require:
      - user: {{ username }}

gitolite_install:
  cmd.run:
    - name: gitolite/install -ln {{ bindir }}
    - user: {{ username }}
    - group: {{ username }}
    - cwd: {{ home }}
    - onchanges:
      - git: gitolite_repo

gitolite_setup:
  cmd.run:
    - name: gitolite setup -pk felix@locutus.pub
    - user: {{ username }}
    - group: {{ username }}
    - cwd: {{ home }}
    - onchanges:
      - cmd: gitolite_install

