FROM centos:centos7.7.1908 

RUN yum -y update
RUN yum -y install openssh-server
RUN yum -y install which
RUN yum -y install lsof
RUN yum -y install nano

#RUN yum -y install initscripts

COPY systemctl.py /usr/bin/systemctl

RUN /usr/bin/ssh-keygen -A

RUN useradd -d /home/deploy -m deploy
RUN mkdir /home/deploy/.ssh
RUN chmod 700 /home/deploy/.ssh
RUN chown -R deploy:deploy /home/deploy/.ssh
RUN touch /home/deploy/.ssh/authorized_keys
RUN chmod 600 /home/deploy/.ssh/authorized_keys
RUN chown -R deploy:deploy /home/deploy/.ssh/authorized_keys

RUN echo 'PS1="\[\e[0;1m\]┌─( \[\e[31;1m\]\u\[\e[0;1m\] docker) – ( \[\e[36;1m\]\w\[\e[0;1m\] )\n└─┤ \[\e[0m\]"' >> /home/deploy/.bashrc
RUN echo 'PS1="\[\e[0;1m\]┌─( \[\e[31;1m\]\u\[\e[0;1m\] docker) – ( \[\e[36;1m\]\w\[\e[0;1m\] )\n└─┤ \[\e[0m\]"' >> /root/.bashrc

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
