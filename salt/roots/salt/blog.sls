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
