Vagrant.configure("2") do |config|

  # Workaround the vbguest error on unmounting /mnt
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end

  config.vm.define "server" do |server|

    server.vm.hostname = "server"
    
    server.vm.box = "centos/7"

    server.vm.provider "virtualbox" do |v|
      v.customize [
         "modifyvm", :id,
         "--memory", "1024",
         "--cpus", "1"
      ]
    end
    
    server.vm.boot_timeout = 600

    server.vm.network :private_network, ip: "10.0.0.10"
    
    server.vm.network "forwarded_port", guest: 8080, host: 8080
    server.vm.network "forwarded_port", guest: 8443, host: 8443

    server.vm.provision "file", source: "Provision-script.sh", destination: "$HOME/Provision-script.sh"

    server.vm.provision "shell", inline: <<-SHELL
      chmod +x /home/vagrant/Provision-script.sh
      /home/vagrant/Provision-script.sh
    SHELL

  end

end

# -*- mode: ruby -*-
# vi: set ft=ruby :
