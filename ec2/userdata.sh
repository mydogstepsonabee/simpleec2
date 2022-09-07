#!/bin/bash
sudo yum update -y
sudo yum -y install docker
sudo systemctl start docker
systemctl enable docker
docker pull vulnerables/web-dvwa
docker pull vulnerables/cve-2014-6271
docker run --name hogehoge -d -p 8080:80 nginx