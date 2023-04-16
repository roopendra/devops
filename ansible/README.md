# Ansible Installation on Ubuntu
```
sudo apt update
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get -y install ansible
ansible --version
sudo apt install python-boto3
sudo apt update
sudo apt install python3-pip
pip show boto3
```

# Install Apache on Ubuntu 22.04

This playbook will install the Apache 2 web server on an Ubuntu 22.04 machine. 


## Update variable as per your setup in vars/default.yml

- `app_user`: a remote non-root user on the Ansible host that will own the application files. 
- `http_host`: your domain name.
- `http_conf`: the name of the configuration file that will be created within Apache.
- `http_port`: HTTP port, default is 80.
- `disable_default`: whether or not to disable the default Apache website. When set to true, your new virtualhost should be used as default website. Default is true.

Below values I have used in case of aws ec2 instance
```
app_user: "ubuntu"
http_host: "ec2-write-your-ip-here.eu-north-1.compute.amazonaws.com"
http_conf: "httpd.conf"
http_port: "80"
disable_default: true
```

## Ansible Playbook Demo



### 1. Get the ansible playbook using git clone
```shell
cd ~ && git clone https://github.com/roopendra/devops.git
cd ~/devops/ansible/demo_without_role
```

### 2. Run the Playbook

```command
ansible-playbook -i [inventory file] [ansible playbook file]
```
## Demo without Ansbile Role
e.g  
Deploy Apache on DEV Hosts  
```ansible-playbook -i ~/devops/ansible/env/dev/hosts.ini ~/devops/ansible/demo_without_role/playbook.yml```

Deploy Apache on UAT Hosts  
```ansible-playbook -i ~/devops/ansible/env/uat/hosts.ini ~/devops/ansible/demo_without_role/playbook.yml```

Deploy Apache on PROD Hosts  
```ansible-playbook -i ~/devops/ansible/env/prod/hosts.ini ~/devops/ansible/demo_without_role/playbook.yml```

## Demo with Ansbile Role

e.g  
Deploy Apache on DEV Hosts  
```ansible-playbook -i ~/devops/ansible/env/dev/hosts.ini ~/devops/ansible/demo_with_role/install_apache.yml```

Deploy Apache on UAT Hosts  
```ansible-playbook -i ~/devops/ansible/env/uat/hosts.ini ~/devops/ansible/demo_with_role/install_apache.yml```

Deploy Apache on PROD Hosts  
```ansible-playbook -i ~/devops/ansible/env/prod/hosts.ini ~/devops/ansible/demo_with_role/install_apache.yml```
