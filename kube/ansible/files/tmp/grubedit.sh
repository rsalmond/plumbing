#!/bin/bash

#carve the line out of the file
grep -v GRUB_CMDLINE_LINUX\= /etc/default/grub > /tmp/grub.new

#grab whatever was in there previously
oldval=$(grep GRUB_CMDLINE_LINUX\= /etc/default/grub | awk -F '=' '{print $2}' | grep -v \")

#add what we need to add and overwrite the old file
echo GRUB_CMDLINE_LINUX=\"${oldval} cgroup_enable=memory\" >> /tmp/grub.new
sudo mv /tmp/grub.new /etc/default/grub

sudo update-grub2