pip:
  pkg.installed:
    - name: python-pip
  pip.uptodate:
    - require:
      - pkg: pip
