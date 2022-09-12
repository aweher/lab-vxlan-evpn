# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
     vb.memory = "8192"
  end

  #

  ## Instalar DOCKER
  config.vm.provision "shell", inline: <<-SHELL
     apt-get update
     apt-get -y install \
       ca-certificates \
       curl \
       gnupg \
       figlet \
       lsb-release
       #
       mkdir -p /etc/apt/keyrings
       curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
       #
       echo \
           "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
       #
       apt-get update
       apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin figlet
       usermod -a -G docker vagrant
  SHELL

  ## Configuracion del docker daemon
  config.vm.provision "shell", inline: <<-SHELL
     echo ***** CONFIGURACION DEL DOCKER DAEMON
     sudo cp /vagrant/daemon.json /etc/docker/
     sudo systemctl restart docker
  SHELL

  ## Instalar ContainerLab
  config.vm.provision "shell", inline: <<-SHELL
     echo ***** INSTALAR CONTAINER LAB
     apt-get update
     bash -c "$(curl -sL https://get.containerlab.dev)"
  SHELL

  # FINAL
  config.vm.provision "shell", inline: <<-SHELL
     docker ps -a
     figlet 'Containerlab Ready!'
  SHELL

end
