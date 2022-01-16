FROM centos:7
RUN yum update -y && \
    yum install epel-release -y && \
    yum install ansible && \
    yum wget unzip python3-pip yum-utils -y && \
    pip3 install boto && \    
    wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip -O /tmp/terraform_0.12.26_linux_amd64.zip && \
    unzip /tmp/terraform_0.12.26_linux_amd64.zip -d /usr/bin

 


