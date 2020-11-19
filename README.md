# vagrant-guacamole

This Vagrant setup is used to test Guacamole with a Linux Desktop.

= Server =

It starts a 'server' VM, which includes de Guacamole server, with
support for its supported protocols (RDP, VNC, SSH, Telnet) together
with its web Interface (clientless remote access). 
It runs a CentOS 7 VM on Virtualbox, provisionned with guacamole 1.2.0

Vagrantfile: Uses "bento/centos-7.1" Vagrant Box to set up a Centos 7 Server with :

- 10246 MB RAM
- 1 CPU
- 1 NAT adapter
- 1 Host only adapter with IP address = "192.168.88.100"
- Hostname="GuacamoleVM"
- User/Password=vagrant/vagrant
- ssh key managed by vagrant ( to manage ssh keys uncomment the section (ssh key management) and change the path to your own key)
- Provisionning script (Provision-script.sh):
    * Based on the following script
      http://pilotfiber.dl.sourceforge.net/project/guacamoleinstallscript/CentOS/guacamole-install-script.sh
      by Hernan Dario Nacimiento
    * Description : (borrowed originally from
         https://sourceforge.net/projects/guacamoleinstallscript/ )

         The script installs dependencies and configure the OS automatically for you in order to obtain the best Remote Desktop Gateway!

         This Install Script works in a clean CentOS 7 installation and installs Guacamole 1.1.0 version for a local users 
         authentication.

         Task of this script:
         Install Packages Dependencies
         Download Guacamole and MySQL Connector packages
         Install Guacamole Server
         Install Guacamole Client
         Install MySQL Connector
         Configure MariaDB or MySQL
         Setting Tomcat Server
         Generates a Java KeyStore for SSL Support
         Install and Setting Nginx Proxy (SPDY enabled)
         Generates a Self-Signed Certificate for SSL Support
         Configure SELinux for Nginx Proxy
         Configure FirewallD or iptables

    * Diagnosis and other details :
      The installation script displays a lot of messages during the VM
      provisionning, which should conclude with something like this:
   
       Your firewall backup file /home/vagrant/guacamole-1.1.0.18-20-Nov.firewall.bkp
       To manage the Guacamole GW go to http://<IP>:8080/guacamole/ or https://<IP>:8443/guacamole/

       The username and password is: guacadmin

      You can then test http://localhost:8080/guacamole/

      vagrant ssh server, then 
      sudo journalctl -f -u guacd
      
= Desktop machine =

It also starts a 'desktop' Linux desktop system, to which Guacamole
can connect through RDP
It runs a Centos 8 desktop with XFCE, using xrdp + xorgxrdp.
The test user is 'testuser'/'testuser'


