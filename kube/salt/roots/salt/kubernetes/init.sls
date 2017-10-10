apt-transport-https:
  pkg.installed

kubernetes-repo:
  pkgrepo.managed:
    - humanname: Kubernetes
    - name: deb http://apt.kubernetes.io/ kubernetes-xenial main
    - file: /etc/apt/sources.list.d/kubernetes.list
    - key_url: https://packages.cloud.google.com/apt/doc/apt-key.gpg

kubernetes-tools:
  pkg.installed:
    - pkgs:
      - kubelet
      - kubeadm
      - kubernetes-cni

/tmp/thing:
  file.managed:
    - contents: 
      - {{ salt['network.interfaces']() }}
