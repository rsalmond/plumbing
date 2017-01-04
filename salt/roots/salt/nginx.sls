nginx:
  pkg:
    - installed
  service.running:
    - watch:
      - pkg: nginx
      - file: /etc/nginx/sites-enabled/*

/etc/nginx/sites-enabled/default:
  file.absent
