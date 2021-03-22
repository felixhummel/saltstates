include:
  - k8s.repo
  - k8s.kubectl

k8s-node:
  pkg.installed:
    - pkgs:
      - kubelet
      - kubeadm
    - hold: True
    - require:
      - pkgrepo: k8s
