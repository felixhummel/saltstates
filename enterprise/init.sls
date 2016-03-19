cifs-utils:
  pkg.installed

/media/storage:
  file.directory:
    - user: felix
    - group: felix
    - mode: 770

/root/.enterprise_smb:
  file.managed:
    - source: salt://enterprise/enterprise_credentials
    - template: jinja
    - mode: 600

