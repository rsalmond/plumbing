install_base_tools:
  pkg.installed:
    - pkgs:
      - vim
git:
  pkg.installed:
    - pkgis:
      - git

phro:
  user.present:
    - name: phro
    - groups:
      - docker

/home/phro/.ssh:
  file.directory:
    - user: phro
    - group: phro
    - mode: 700
    - require:
      - user: phro

/home/phro/.ssh/authorized_keys:
  file.managed:
    - source: salt://assets/id_salmond_ca.pub
    - user: phro
    - group: phro
    - mode: 0600
    - require:
      - file: /home/phro/.ssh
