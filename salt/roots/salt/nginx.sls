nginx:
  pkg:
    - installed
  service.running:
    - watch:
      - pkg: nginx
      - file: /etc/nginx/sites-enabled/*

/etc/nginx/sites-enabled/default:
  file.absent

/etc/nginx/sites-enabled/blog:
  file.managed:
    - template: jinja
    - source: salt://templates/nginx-configs/blog.j2
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: nginx
