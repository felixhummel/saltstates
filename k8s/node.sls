k8s-node:
  pkg.installed:
    - pkgs:
      - kubelet
      - kubeadm
    - hold: True
