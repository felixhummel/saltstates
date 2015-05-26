canonical_partner:
  pkgrepo.managed:
    - name: deb http://archive.canonical.com/ {{ grains['oscodename'] }} partner
    - dist: {{ grains['oscodename'] }}
    - file: /etc/apt/sources.list.d/canonical-partner-ppa.list

skype:
  pkg.installed:
    - require:
      - pkgrepo: canonical_partner

