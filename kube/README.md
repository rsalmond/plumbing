## vas ist das:

A bunch of stuff to manage my personal servers. Featuring such thingies as:

 * Vagrantfile for local hacking
 * ansible playbooks to install docker and kubernetes
 * scripts to apply playbooks to prod and dev
 * a postscript to apply various system level kubernetes manifests (kubenet, ingress, secrets, etc.)

## requirements:

`vagrant plugin install vagrant-vbguest`

## use:

For local hacking: `./local-hacking.sh`

Deploy prod: `./prod-ansible.sh ansible/base.yaml`
