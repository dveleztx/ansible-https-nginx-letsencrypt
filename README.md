# Deploy HTTPS Website using NGINX with LetsEncrypt Certs via Ansible 2

## Pre-requisites

### Use my Vagrant Box for your Ansible Server (or make your own)
- [Download](https://app.vagrantup.com/dveleztx/boxes/ansible-server-flaskgunginx) our Vagrant Box from the Cloud
- `vagrant box add dveleztx/ansible-server-flaskgunginx`
- `vagrant up`
- `vagrant ssh`

### Configure Vagrantfile
```ruby
Vagrant.configure("2") do |config|
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/bionic64"
  config.vm.hostname = "ansible-box"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network "public_network"
end
```
- **NOTE:** The above configuration file is the vagrant config for your machine, you'll notice that the network is set to public network, as it explains, your hosting machine will act as a bridge to bring your machine onto the network. You could set the network to be private if you like, if you do, look at Vagrant's documentation to understand private networks.

#### Configure Ansible
- `sudo vim /etc/ansible/ansible.cfg` - make sure to uncomment the host_key_checking and set it to False per the following:
```
[defaults]
host_key_checking = False
```
- Configure what hosts Ansible Server will connect to
  - Each one of the *target* machines need to have python and SSH setup
  - `sudo vim /etc/ansible/host` - the following code block is an **example** of a setup
```
[webservers]
192.168.1.10 ansible_ssh_port=22 ansible_ssh_user=vagrant ansible_ssh_private_key_file=/home/vagrant/.ssh/id_rsa
```

## Prep the Webserver using Ansible

- Git clone the repo and let's do some work
- `cd /etc/ansible; sudo mkdir playbooks; cd playbooks`
- `git clone https://github.com/dveleztx/ansible-https-nginx-letsencrypt.git && cd ansible-https-nginx-letsencrypt`
- Run this [script](https://github.com/TAMUSA-ACM/ansible-flask-gunicorn-nginx/blob/master/prepare_ansible_target.yml) from your ansible server to setup your target webserver
  - Use the following command to execute ansible execution of the YML script: `sudo ansible-playbook prepare_ansible_target.yml -i /etc/ansible/hosts -u vagrant -k --ask-sudo-pass` - This will prompt you for the password for vagrant, enter the password and this will automatically install python for you, which is needed to do automation. This will also enter your private SSH key into authorized_keys on the target machine, saving you from having to enter creds in the future
  
## Execute Webserver Playbook for Deployment
- Using my playbook, a lot of the heavy lifting thankfully has been done, if you are curious to see the details of it, feel free to look through the [YML Script](https://github.com/dveleztx/ansible-https-nginx-letsencrypt/blob/master/nginx-https/nginx-setup.yml)
- Execute the script from the Ansible Server: `sudo ansible-playbook nginx-setup.yml -u root -i /etc/ansible/hosts`

Now just explore to the site and it should have your hello world encrypted via HTTPS!

## References

- Support David Cohen, author of Ansible 2 for Beginners: https://www.udemy.com/ansible-2-for-beginners/
