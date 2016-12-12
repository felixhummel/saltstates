/etc/default/crda:
  file.managed:
    - mode: 644
    - source: salt://desktop/wlan/crda
    - template: jinja
    - context:
      REGDOMAIN: DE

