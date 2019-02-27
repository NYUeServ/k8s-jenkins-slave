FROM jenkins/slave:3.27-1
MAINTAINER Eric Lin <eric.lin@nyu.edu>
LABEL Description="NYU's docker image used in jenkins to build and deploy"

USER root
COPY jenkins-slave /usr/local/bin/jenkins-slave
RUN ["chmod", "+x", "/usr/local/bin/jenkins-slave"]

USER jenkins

ENTRYPOINT ["jenkins-slave"]
