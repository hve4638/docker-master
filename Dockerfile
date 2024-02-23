FROM ubuntu:latest

RUN set -x \
&& apt update \
&& apt install -y curl \
&& apt install -y openssh-server

RUN curl -sSL get.docker.com | sh

RUN curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-Linux-x86_64" -o /usr/local/bin/docker-compose \
&& chmod +x /usr/local/bin/docker-compose \
&& ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

RUN sed 's/#Port.*/Port 3022/' -i /etc/ssh/sshd_config \
&& sed 's/#AuthorizedKeysFile.*/PubkeyAuthentication yes/' -i /etc/ssh/sshd_config

RUN addgroup --gid 1000 master \
&& adduser --home /home/master --gid 1000 --shell /bin/bash --uid 1000 --gecos '' --disabled-password master \
&& mkdir -p /home/master/.ssh \
&& usermod -aG docker master \
&& touch /home/master/.hushlogin

COPY .aliaslist /home/master/.aliaslist

RUN echo "source ~/.aliaslist" >> /home/master/.bashrc

RUN mkdir /vol \
&& chmod 700 /vol