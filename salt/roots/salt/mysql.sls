mysql:
  pkg.installed:
    - pkgs:
      - mysql-client
      - mysql-server
  service.running: []

ghost:
  mysql_user.present:
    - host: localhost
    - password_hash: "*BEE2C8CFD62D0D204A113241A4E1A65FE80421D3"
    - connection_user: root
    - connection_pass:
    - connection_charset: utf8
    - saltenv:
      - LC_ALL: "en_US.utf8"

ghost_grant:
   mysql_grants.present:
    - grant: select,insert,update,delete
    - database: ghostblog.*
    - user: ghost
    - host: localhost
