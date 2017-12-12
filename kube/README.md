## requirements:

vagrant plugin install vagrant-vbguest

enable memory cgroups:
 * add `"cgroup_enable=memory"` to `GRUB_CMDLINE_LINUX` in `/etc/default/grub`
 * run `sudo update-grub2`
 * `reboot -n`
 
