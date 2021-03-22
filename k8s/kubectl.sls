include:
  - k8s.repo

kubectl:
  pkg.installed:
    - require:
      - pkgrepo: k8s
