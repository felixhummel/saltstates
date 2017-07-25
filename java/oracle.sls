# https://gist.github.com/renoirb/6722890

oracle-ppa:
  pkgrepo.managed:
    - humanname: WebUpd8 Oracle Java PPA repository
    - ppa: webupd8team/java

oracle-license-select:
  cmd.run:
    - unless: which java
    - name: '/bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections'
    - prereq:
      - pkg: oracle-java8-installer
      - cmd: oracle-license-seen

oracle-license-seen:
  cmd.run:
    - name: '/bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 seen true  | /usr/bin/debconf-set-selections'
    - prereq:
      - pkg: oracle-java8-installer

oracle-java8-installer:
  pkg.installed:
    - require:
      - pkgrepo: oracle-ppa
