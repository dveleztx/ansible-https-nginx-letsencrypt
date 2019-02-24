# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what # you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/bionic64"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network "public_network"

  # Greeting
  if Dir.glob("#{File.dirname(__FILE__)}/.vagrant/machines/default/*").empty? || ARGV[0] == 'provision'
    print "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
    print " Hello, #{ENV['USER']}. This script will help you setup your ansible server. \n"
    print "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
    print "+                                                                       +\n"
    print "+           ANSWER THE NEXT COUPLE OF QUESTIONS TO PROCEED!!!           +\n"
    print "+                                                                       +\n"
    print "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"

    # Obtain Variables via User Entry
    print "Enter your FQDN (Fully Qualified Domain Name, i.e. myproject.com) and press [Enter]: " 
    HOST = STDIN.gets.chomp
    print "\nEnter the username of the remote web server you are setting up (i.e. root, user). This will be the user account we will be sshing into! Enter username and press [Enter]: "
    SSH_REMOTE_USER = STDIN.gets.chomp
    print "\nWhat is the vagrant machine user account being used to launch ansible playbooks, enter username and press [Enter]: "
    SSH_LOCAL_USER = STDIN.gets.chomp
    print "\n"

    # Enable provisioning with a shell script. Additional provisioners such as
    # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
    # documentation for more information about their specific syntax and use.
    config.vm.provision :shell, :path => "setup-ansible-on-vagrant.sh", :args => [HOST, SSH_REMOTE_USER, SSH_LOCAL_USER]

  end

  # Ansible Configuration
  #config.vm.provision "ansible" do |ansible|
  #  ansible.verbose = "v"
  #  ansible.playbook = "nginx-https/nginx-setup.yml"
  #  ansible.groups = {
  #    "webservers" => ["cmlink.ddns.net"],
  #  }
  #  ansible.extra_vars = {
  #    "user_name" => "dveleztx",
  #    "letsencrypt_email" => "dveleztx@gmail.com",
  #  }
  #end

end
