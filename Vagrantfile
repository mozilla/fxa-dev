# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box_url = "packer/sl64-virtualbox.box"
  config.vm.box = "sl64"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.network "private_network", type: "dhcp"

  config.vm.provider "virtualbox" do |vb, override|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.memory = 384
    vb.cpus = 1
  end

  config.vm.provider "vmware_fusion" do |vw, override|
    override.vm.box_url = "packer/sl64-vmware.box"
    vw.vmx["memsize"] = "384"
    vw.vmx["numvcpus"] = "1"
  end

  config.vm.define "auth" do |auth|
    auth.vm.hostname = 'auth'
  end

  config.vm.define "content" do |content|
    content.vm.hostname = 'content'
  end

  config.vm.define "customs" do |customs|
    customs.vm.hostname = 'customs'
  end

  config.vm.define "log" do |log|
    log.vm.hostname = 'log'
  end

  config.vm.define "db" do |db|
    db.vm.hostname = 'db'
    db.vm.provision "ansible" do |ansible|
      ansible.playbook = "local.yml"
      #ansible.verbose = 'vvv'
      ansible.limit = 'all'
    end
  end
end
