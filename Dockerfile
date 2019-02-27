FROM jenkins/slave:3.27-1
MAINTAINER Eric Lin <eric.lin@nyu.edu>
LABEL Description="NYU's docker image used in jenkins to build and deploy"

COPY jenkins-slave /usr/local/bin/jenkins-slave

RUN cat /etc/os-release

ENTRYPOINT ["jenkins-slave"]
