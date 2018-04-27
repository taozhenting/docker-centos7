FROM centos:latest
MAINTAINER tom.tao
COPY ./mysql57-community-release-el7-11.noarch.rpm /usr/local/src/
COPY ./epel-release-latest-7.noarch.rpm /usr/local/src/
RUN rpm -ivh /usr/local/src/epel-release-latest-7.noarch.rpm
RUN rpm -ivh /usr/local/src/mysql57-community-release-el7-11.noarch.rpm
RUN yum install -y openssh-server openssh-clients net-tools traceroute telnet sudo mysql-community-client
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN echo 'root:tom123' | chpasswd
RUN systemctl enable sshd
RUN yum install -y httpd httpd-devel
RUN mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak
COPY ./httpd.conf /etc/httpd/conf/
RUN systemctl enable httpd
RUN chown apache. -R /var/www/html
