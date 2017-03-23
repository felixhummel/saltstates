gitlab_repo_needs_apt_via_https:
  pkg.installed:
    - name: apt-transport-https

gitlab-ce:
  pkgrepo.managed:
    - name: deb https://packages.gitlab.com/gitlab/gitlab-ce/ubuntu/ {{ grains['oscodename'] }} main
    - file: /etc/apt/sources.list.d/gitlab.list
    - key_url: https://packages.gitlab.com/gpg.key
    - require:
      - pkg: gitlab_repo_needs_apt_via_https
  pkg.installed: []

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

