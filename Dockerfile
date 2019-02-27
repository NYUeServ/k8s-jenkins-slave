FROM jenkins/slave:3.27-1
MAINTAINER Eric Lin <eric.lin@nyu.edu>
LABEL Description="NYU's docker image used in jenkins to build and deploy"

USER root
COPY jenkins-slave /usr/local/bin/jenkins-slave
RUN ["chmod", "+x", "/usr/local/bin/jenkins-slave"]

# Update packages from source
RUN apt-get update

# Install unzip & git (Already included in debian, which is in the base image)

# Install software-properties-common and apt-transport-https
RUN apt-get -y install software-properties-common apt-transport-https

# Install ansible
RUN apt-get -y install ansible jq

# Install python 3
RUN apt-get -y install python3 python3-pip

# Install dependencies for openshift for paramiko
RUN apt-get -y install build-essential libssl-dev libffi-dev python-dev

USER jenkins

# Install awscli via pip
RUN pip3 install awscli

# Install boto via pip
RUN pip3 install boto

# Install openshift via pip
RUN pip3 install openshift

ENTRYPOINT ["jenkins-slave"]
