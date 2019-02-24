# Deploy HTTPS Website using NGINX with LetsEncrypt Certs via Ansible 2

## Pre-requisites

### Download ubuntu/bionic64 Vagrant Image
- `vagrant box add ubuntu/bionic64`
- `vagrant init ubuntu/bionic64`
- `vagrant up`
- `vagrant ssh`

### Configure Vagrantfile for Prep
```ruby
Vagrant.configure("2") do |config|
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/bionic64"
  config.vm.hostname = "ansible-box"
  
  # Run setup script
  config.vm.provision "shell", path: "setup-ansible-on-vagrant.sh"
end
```
- **NOTE:** The above configuration file is the vagrant config for your machine, which includes a shell script that will automatically configure ansible on your vagrant machine. This will automate a lot of the process. 

#### Install Ansible
- `vagrant provision` - **NOTE:** The variables defined in the setup-ansible-for-vagrant.sh script needs to be updated with your own relevant information, otherwise, this won't work!

## Prep the Webserver using Ansible

- Run this [script](https://github.com/TAMUSA-ACM/ansible-flask-gunicorn-nginx/blob/master/prepare_ansible_target.yml) from your ansible server to setup your target webserver
  - Use the following command to execute ansible execution of the YML script: `sudo ansible-playbook prepare_ansible_target.yml -i /etc/ansible/hosts -u vagrant -k --ask-sudo-pass` - This will prompt you for the password for vagrant, enter the password and this will automatically install python for you, which is needed to do automation. This will also enter your private SSH key into authorized_keys on the target machine, saving you from having to enter creds in the future
  
## Execute Webserver Playbook for Deployment
- Using my playbook, a lot of the heavy lifting thankfully has been done, if you are curious to see the details of it, feel free to look through the [YML Script](https://github.com/dveleztx/ansible-https-nginx-letsencrypt/blob/master/nginx-https/nginx-setup.yml)
- Execute the script from the Ansible Server: `sudo ansible-playbook nginx-setup.yml -u root -i /etc/ansible/hosts`

Now just explore to the site and it should have your hello world encrypted via HTTPS!

## References

- Support David Cohen, author of Ansible 2 for Beginners: https://www.udemy.com/ansible-2-for-beginners/
