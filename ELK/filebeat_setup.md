# Filebeat-7.17 Installation on Ubuntu and CentOS system

## Follow the below insturctions for Ubuntu
```
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update && sudo apt-get install filebeat
sudo systemctl enable filebeat
 ```

## Follow the below instructions for CentOS
```
sudo rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
```
Create a file with a .repo extension (for example, elastic.repo) in your ***/etc/yum.repos.d/*** directory and add the following lines:
```
[elastic-7.x]
name=Elastic repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
```
Install filebeat
```
sudo yum install filebeat
sudo systemctl enable filebeat
```

### Configure a sample log file to index in Elasticsearch
/etc/filebeat/filebeat.yml
```
filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /var/log/sample_log/apache_access.log

output.logstash:
  hosts: ["localhost:5044"]
```
Create Logstash config under /etc/logstash/conf.d/apache_parse.conf
```
input {
   beats {
     port => "5044"
  }
}
filter {
   grok {
      match => { "message" => "%{COMBINEDAPACHELOG}" }
   }
   geoip {
     source => "clientip"
   }
}

output {
    elasticsearch {
       hosts => [ "localhost:9200" ]
    }
}
```
**Delete Old FileBeat Registry**
```
sudo rm -f /var/lib/filebeat/registry

```

Validate the config 
```
sudo /usr/share/logstash/bin/logstash -f  /etc/logstash/conf.d/apache_parse.conf --config.test_and_exit
```
If the configuration file passes the configuration test, start Logstash with the following command: 
```
sudo /usr/share/logstash/bin/logstash -f  /etc/logstash/conf.d/apache_parse.conf --config.reload.automatic
```

#### References 
https://www.elastic.co/guide/en/logstash/7.17/advanced-pipeline.html   
https://www.elastic.co/guide/en/beats/filebeat/7.17/filebeat-installation-configuration.html
