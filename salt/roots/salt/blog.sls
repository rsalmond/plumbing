blog:
  user.present:
    - name: blog
    - shell: /bin/false
    - home: /home/blog
    - groups:
      - docker

git-clone:
  git.latest:
    - name: https://github.com/rsalmond/rob-salmond-ca.git
    - rev: master
    - target: /home/blog/rob-salmond-ca
    - require:
        - pkg: git

blog/ghost:latest:
  dockerng.image_present:
    - build: /home/blog/rob-salmond-ca/

add-supervisor-config:
  file:
    - managed
    - name: /etc/supervisor/conf.d/blog.conf
    - source: salt://supervisor/configs/default.conf
    - user: root
    - group: root
    - mode: 600
    - require:
      - supervisor
