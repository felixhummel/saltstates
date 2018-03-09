{% set domain = salt['pillar.get']('postfix:domain', []) %}
{% set selector = 'mail' %}


opendkim-tools:
  pkg.installed

{% set keydir = '/etc/opendkim/keys/' + domain %}
{{ keydir }}:
  file.directory:
    - makedirs: True
    - dir_mode: 700

{% set pubkey_path = keydir + '/' + selector + '.txt' %}
{% set privkey_path = keydir + '/' + selector + '.private' %}
opendkim-genkey -s {{ selector }} -d {{ domain }}:
  cmd.run:
    - cwd: {{ keydir }}
    - unless: test -f {{ privkey_path }}

dkim:pubkey:
  grains.present:
    - force: true
    - value: {{ pubkey_path }}
    - require:
      - cmd: opendkim-genkey -s {{ selector }} -d {{ domain }}
