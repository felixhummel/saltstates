include:
  - .installed

/etc/gitlab/gitlab.rb:
  file.managed:
    - source: salt://gitlab/gitlab.rb
    - backup: minion
    - mode: 600

gitlab_reconfigure:
  cmd.run:
    - name: gitlab-ctl reconfigure
    - onchanges:
      - file: /etc/gitlab/gitlab.rb


