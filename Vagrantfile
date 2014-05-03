# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box_url = "packer/sl64-virtualbox.box"
  config.vm.box = "sl64"
  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |v, override|
    override.vm.network "private_network", type: "dhcp"
    v.memory = 512
    v.cpus = 1
  end

  config.vm.provider "vmware_fusion" do |v, override|
    override.vm.box_url = "packer/sl64-vmware.box"
    v.vmx["memsize"] = "512"
    v.vmx["numvcpus"] = "1"
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

  config.vm.define "db" do |db|
    db.vm.hostname = 'db'
    db.vm.provision "ansible" do |ansible|
      ansible.playbook = "local.yml"
      #ansible.verbose = 'vvvv'
      ansible.limit = 'all'
    end
  end
end
