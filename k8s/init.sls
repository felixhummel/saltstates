include:
  - apt_transport_https

# It's xenial (even for debian)
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
k8s:
  pkgrepo.managed:
    - name: deb https://apt.kubernetes.io/ kubernetes-xenial main
    - file: /etc/apt/sources.list.d/kubernetes.list
    - key_url: https://packages.cloud.google.com/apt/doc/apt-key.gpg
    - require:
      - pkg: apt_transport_https
