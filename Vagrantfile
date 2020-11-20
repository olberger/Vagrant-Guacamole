Vagrant.configure("2") do |config|

  # Workaround the vbguest error on unmounting /mnt
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end

  # Guacamole Server part
  
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

    server.vm.provision "file", source: "provision-server.sh", destination: "$HOME/Provision-script.sh"
    server.vm.provision "shell", inline: <<-SHELL
      chmod +x /home/vagrant/Provision-script.sh
      /home/vagrant/Provision-script.sh
    SHELL
  end

  
  # Desktop Endpoint part
  
  config.vm.define "desktop" do |desktop|

    desktop.vm.hostname = "desktop"
    
    desktop.vm.box = "bento/centos-8"

    desktop.vm.network :private_network, ip: "10.0.0.20"

    desktop.vm.synced_folder '.', '/vagrant', type: "rsync"
    
    desktop.vm.boot_timeout = 600
    desktop.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      #vb.gui = true
      # Customize Name of VM:
      #      vb.name = "centos-7.5.1804-1549879089-x86-64"
      # Customize the amount of memory on the VM:
      vb.memory = "4096"
      # Customize video memory
      vb.customize ["modifyvm", :id, "--vram", "32"]
      # Enable 3D acceleration:
      # vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
      # Shared Clipboard
      #vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
      # Enable Drag and Drop
      #vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
      # Enable Remote Display
      #      vb.customize ["modifyvm", :id, "--vrde", "on"]
      #      vb.customize ["modifyvm", :id, "--vrdeport", "5000,5010-5012"]
    end

    # Upgrade and reboot
    #  # Running Provisioners Always
    #  desktop.vm.provision "shell", run: "always" do |s|
    #    #    s.inline = "sudo yum-complete-transaction --cleanup-only && sudo yum -y update"
    #    s.inline = "sudo yum -y update"
    #  end
    desktop.vm.provision "shell", run: "always", inline: <<-SHELL
        yum -y update
        yum install -y epel-release
        # Yum upgrade
        yum -y upgrade
    SHELL
    desktop.vm.provision :reload
    
    desktop.vm.provision "file", source: "provision-desktop.sh", destination: "$HOME/Provision-script.sh"
    desktop.vm.provision "shell", inline: <<-SHELL
      chmod +x /home/vagrant/Provision-script.sh
      /home/vagrant/Provision-script.sh
    SHELL
    
  end

end

# -*- mode: ruby -*-
# vi: set ft=ruby :
