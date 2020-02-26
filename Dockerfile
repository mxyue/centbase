FROM centos:centos7.7.1908 

RUN yum -y update
RUN yum -y install openssh-server
RUN yum -y install which
RUN yum -y install lsof
RUN yum -y install nano

#RUN yum -y install initscripts

COPY systemctl.py /usr/bin/systemctl

RUN /usr/bin/ssh-keygen -A

RUN mkdir /root/.ssh
RUN chmod 700 /root/.ssh
RUN touch /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

RUN echo 'PS1="\[\e[0;1m\]┌─( \[\e[31;1m\]\u\[\e[0;1m\] docker) – ( \[\e[36;1m\]\w\[\e[0;1m\] )\n└─┤ \[\e[0m\]"' >> /root/.bashrc

ADD ./git.repo /etc/yum.repos.d/
RUN rpm --import http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco
RUN yum -y install git

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
