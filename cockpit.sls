# Cockpit makes it easy to administer your GNU/Linux servers via a web browser.
# http://cockpit-project.org/
cockpit:
  pkgrepo.managed:
    - ppa: cockpit-project/cockpit
  pkg.installed:
    - refresh: True
  service.enabled:
    - name: cockpit.socket

