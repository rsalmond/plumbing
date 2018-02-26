# plumbing
My server management stuff

## Terraform

[Mostly](terraform/) route53 stuff.

## Kube

Ansible, scripts, a Vagrantfile, and some kubernetes manifests for turning both a local VM and/or a VPS into a poor mans single node kubernetes "cluster".

__hacking__

Run `local-hacking.sh` to:

 * Bring up a vagrant box (jessie/scratch) with the [necessary kernel params](https://github.com/kubernetes/kubernetes/issues/54914#issuecomment-341029478).
 * Run ansible playbooks to set up repos, base packages, initialize kubernetes, and fetch the kubeconfig file.
 * Apply kube manifests to enable networking, add docker image secrets for GCR, enable nginx ingress controller

 Currently supports debian9 boxes.
