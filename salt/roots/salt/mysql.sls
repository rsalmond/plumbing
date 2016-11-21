mysql:
  pkg.installed:
    - pkgs:
      - mysql-client
      - mysql-server
  service.running: []
