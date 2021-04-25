FROM jenkins/jenkins:2.277.1-lts-jdk11
USER root
RUN apt-get update && apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.24.5 docker-workflow:1.26"

USER root
RUN set -xe \
	&& apt-get update \
	&& apt-get install -y python3.7 \
	&& apt-get install -y python3-pip \
	&& apt-get install -y python3-venv
RUN pip3 install --upgrade pip
USER jenkins
COPY requirements.txt .
RUN pip3 install -r requirements.txt
