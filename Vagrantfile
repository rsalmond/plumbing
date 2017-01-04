# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

def provisioning?()
  # true if the current vagrant command will result in a provisioning run
  provisioning_cmds = ['provision', 'up']
  provisioning_cmds.include?(ARGV[0].downcase)
end

Vagrant.configure(2) do |config|
  config.ssh.forward_agent = true
  if not provisioning?
    config.ssh.username = 'phro'
    config.ssh.private_key_path = '~/.ssh/id_salmond_ca'
  end
  config.vm.box = "debian/contrib-jessie64"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "salt/roots", "/srv/"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end
  config.vm.provision :salt do |salt|
    salt.masterless = true
    salt.grains_config = "salt/grains-dev"
    salt.minion_config = "salt/minion-config"
    salt.install_type = "stable"
    salt.verbose = true
    salt.colorize = true
    salt.run_highstate = true
  end
end
