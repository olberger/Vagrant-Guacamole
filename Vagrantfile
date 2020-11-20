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

  config.vm.define "desktop" do |desktop|

    desktop.vm.hostname = "desktop"
    
    # desktop.vm.box = "nitindas/centos-8.0"
    # desktop.vm.box_version = "0.1905-1579100378"
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
    
    desktop.vm.provision "shell", run: "always", inline: <<-SHELL

        yum groupinstall "Xfce" -y
      
      adduser testuser
      echo testuser:testuser | chpasswd testuser

      # Honor locale before starting XFCE4 session
      echo '#!/bin/bash
# xrdp X session start script (c) 2015, 2017 mirabilos
# published under The MirOS Licence
if test -r /etc/profile; then
    . /etc/profile
fi
if test -r /etc/locale.conf; then
    . /etc/locale.conf
    test -z "${LANG+x}" || export LANG
    test -z "${LANGUAGE+x}" || export LANGUAGE
    test -z "${LC_ADDRESS+x}" || export LC_ADDRESS
    test -z "${LC_ALL+x}" || export LC_ALL
    test -z "${LC_COLLATE+x}" || export LC_COLLATE
    test -z "${LC_CTYPE+x}" || export LC_CTYPE
    test -z "${LC_IDENTIFICATION+x}" || export LC_IDENTIFICATION
    test -z "${LC_MEASUREMENT+x}" || export LC_MEASUREMENT
    test -z "${LC_MESSAGES+x}" || export LC_MESSAGES
    test -z "${LC_MONETARY+x}" || export LC_MONETARY
    test -z "${LC_NAME+x}" || export LC_NAME
    test -z "${LC_NUMERIC+x}" || export LC_NUMERIC
    test -z "${LC_PAPER+x}" || export LC_PAPER
    test -z "${LC_TELEPHONE+x}" || export LC_TELEPHONE
    test -z "${LC_TIME+x}" || export LC_TIME
    test -z "${LOCPATH+x}" || export LOCPATH
fi
if test -r /etc/profile; then
    . /etc/profile
fi

#echo "mode:             blank" > $HOME/.xscreensaver

#xfconf-query -c xfwm4 -p /general/workspace_count -s 1
#xfconf-query -c xfce4-session -np "/shutdown/ShowSuspend" -t "bool" -s "false"
#xfconf-query -c xfce4-session -np "/shutdown/ShowHibernate" -t "bool" -s "false"

#test -x /etc/X11/Xsession && exec /etc/X11/Xsession
#exec /bin/sh /etc/X11/Xsession
exec /bin/sh /usr/bin/startxfce4
' > /home/testuser/startwm.sh



      chown testuser:testuser /home/testuser/startwm.sh
      chmod +x /home/testuser/startwm.sh

      yum install -y xrdp
      yum install -y xorgxrdp

       echo 'allowed_users = anybody
       ' > /etc/X11/Xwrapper.config

       systemctl enable xrdp
       systemctl start xrdp

   SHELL
    
  end

  end
  
end

# -*- mode: ruby -*-
# vi: set ft=ruby :
