de_locale:
  locale.present:
    # see /var/lib/locales/supported.d/de
    - name: de_DE.UTF-8

/etc/default/locale:
  file.managed:
    - source: salt://locale/etc_default_locale
    - require:
      - locale: de_locale
