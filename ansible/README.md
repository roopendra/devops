## Ansible Playbook Demo on AWS EC2 instance
1) Create two aws ec2 ubuntu instances ( 1 master, 2 app-server1 )
2) Install Ansible on master node 
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

3) Create ssh key in master node  
```ssh-keygen -t rsa```
4) Copy the public key   
```cat ~/.ssh/id_rsa.pub```

5) Login in app node and add the key in `~/.ssh/authorized_keys` file  
- vi `~/.ssh/authorized_keys`  
- press i ( or insert )  
- paste the key which you copied in step 4
- esc :wq!

6) Go to master ec2 instance and ssh app ec2 instance to validate ssh connectivity   
``ssh <public_ip_of_app_node>```

7) Clone the devops repository for ansible demo : https://github.com/roopendra/devops/tree/master/ansible
```
cd ~ && git clone https://github.com/roopendra/devops.git
cd ~/devops/ansible/demo_without_role
```

8) Update the app_user and http_host value in ``~/devops/ansible/demo_without_role/vars/default.yml``
```
---
app_user: "ubuntu"
http_conf: "httpd.conf"
http_port: "80"
disable_default: true
```
9) Update the public ipv4 address and DNS name of app node in inventory file ~/devops/ansible/env/dev/hosts.ini     
```	
[apache_hosts]
<IPv4 address> http_host=<IPv4 DNS Address>
e.g.
192.168.0.1 http_host="ec2-some-ip-here.eu-north-1.compute.amazonaws.com"
```
10) Run the playbook to install apache on app node   
```ansible-playbook -i ~/devops/ansible/env/dev/hosts.ini ~/devops/ansible/demo_without_role/playbook.yml```


**For ansible role demo**  
11) Run below playbook command   
```ansible-playbook -i ~/devops/ansible/env/dev/hosts.ini ~/devops/ansible/demo_with_role/install_apache.yml```


### Ansible Playbook Syntax

```command
ansible-playbook -i [inventory file] [ansible playbook file]
```
## Ansible command reference
e.g  
Deploy Apache on DEV Hosts  
```ansible-playbook -i ~/devops/ansible/env/dev/hosts.ini ~/devops/ansible/demo_without_role/playbook.yml```

Deploy Apache on UAT Hosts  
```ansible-playbook -i ~/devops/ansible/env/uat/hosts.ini ~/devops/ansible/demo_without_role/playbook.yml```

Deploy Apache on PROD Hosts  
```ansible-playbook -i ~/devops/ansible/env/prod/hosts.ini ~/devops/ansible/demo_without_role/playbook.yml```

## Ansible role command reference

e.g  
Deploy Apache on DEV Hosts  
```ansible-playbook -i ~/devops/ansible/env/dev/hosts.ini ~/devops/ansible/demo_with_role/install_apache.yml```

Deploy Apache on UAT Hosts  
```ansible-playbook -i ~/devops/ansible/env/uat/hosts.ini ~/devops/ansible/demo_with_role/install_apache.yml```

Deploy Apache on PROD Hosts  
```ansible-playbook -i ~/devops/ansible/env/prod/hosts.ini ~/devops/ansible/demo_with_role/install_apache.yml```
