# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'shellwords'

def bash(command)
  escaped_command = Shellwords.escape(command)
  system "bash -c #{escaped_command}"
end

# The RSA file below MUST BE the RSA that you use
# to connect to Github, otherwise you cannot clone.
bash("key_file=~/.ssh/id_rsa; [[ -z $(ssh-add -L | grep $key_file) ]] && ssh-add $key_file")

Vagrant.configure(2) do |config|
  config.vm.box = "laravel/homestead"
  config.vm.box_url = ""
  config.vm.hostname = "" #Fill this is for client Ex. VM-APP-CLIENT-01
  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network "forwarded_port", guest: 443, host: 443
  config.vm.network "public_network",
  bridge: "en0: Wi-Fi (AirPort)",
  use_dhcp_assigned_default_route: true

  config.vm.synced_folder "./data", "/vagrant_data"
  config.vm.synced_folder "./src", "/var/www/html"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
  config.ssh.forward_agent = true
  config.vm.provision :shell , inline: "(grep -q 'mesg n' /root/.profile && sed -i '/mesg n/d' /root/.profile && echo 'Ignore the previous error, fixing this now...') || exit 0;"
  config.vm.provision :shell, path: "./vagrant_inc/mute_ssh.sh"
  config.vm.provision :shell, path: "./vagrant_inc/bootstrap.sh"

config.vm.post_up_message = `$(vagrant ssh -c "ip address show eth0" 2>/dev/null | sed -ne '/inet / s/\s\+inet \([^\/]\+\).*\r/\1/p')`
end
