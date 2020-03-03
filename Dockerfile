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

ADD git.repo /etc/yum.repos.d/
RUN rpm --import http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco
RUN yum -y install git

RUN yum -y install make
RUN yum -y install gcc gcc+ gcc-c++

RUN yum install -y epel-release 

RUN rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
RUN yum -y install nginx

RUN yum -y install crontabs

RUN yum -y install net-tools
RUN yum -y install telnet
RUN yum -y install monit

COPY monitrc /etc/
RUN chmod 700 /etc/monitrc
COPY monit_crond /etc/monit.d/
COPY monit_sshd /etc/monit.d/
COPY monit_nginx /etc/monit.d/


ENTRYPOINT ["/usr/bin/monit", "-I"]


