install_base_tools:
  pkg.installed:
    - pkgs:
      - vim

vagrant:
  user.present:
    - name: vagrant
    - groups:
      - docker
