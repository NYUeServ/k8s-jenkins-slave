FROM jenkins/slave:3.27-1
MAINTAINER Eric Lin <eric.lin@nyu.edu>
LABEL Description="NYU's docker image used in jenkins to build and deploy"

# Assume as root user
USER root

# Initialize jenkins-slave agent
COPY jenkins-slave /usr/local/bin/jenkins-slave
RUN ["chmod", "+x", "/usr/local/bin/jenkins-slave"]

# Retrieve aws-iam-authenticator from AWS
RUN curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator
RUN ["chmod", "+x", "./aws-iam-authenticator"]
RUN mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator

# Add ansible source
RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367

# Update packages from source
RUN apt-get update

# Install unzip & git (Already included in debian, which is in the base image)

# Install software-properties-common and apt-transport-https
RUN apt-get -y install software-properties-common apt-transport-https

# Install ansible
RUN apt-get -y install ansible

# Install json query
RUN apt-get -y install jq

# Install python 3
RUN apt-get -y install python3 python3-pip

# Install dependencies for openshift for paramiko
RUN apt-get -y install build-essential libssl-dev libffi-dev python-dev

# Install awscli via pip (requires root)
RUN pip3 install awscli --upgrade

# Install boto via pip
RUN pip3 install boto

# Install openshift via pip
RUN pip3 install openshift

USER jenkins

ENTRYPOINT ["jenkins-slave"]
