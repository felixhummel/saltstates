obs_repo:
  pkgrepo.managed:
    - ppa: obsproject/obs-studio

obs-studio:
  pkg.installed:
    - require:
      - pkgrepo: obs_repo
