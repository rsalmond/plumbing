install_base_tools:
  pkg.installed:
    - pkgs:
      - vim
      - git

vagrant:
  user.present:
    - name: vagrant
    - groups:
      - docker
