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
RUN yum install -y wget gcc make apr-devel apr-util-devel pcre-devel libxml2-devel curl-devel gd-devel openssl-devel autoconf libjpeg-devel libpng-devel libxslt-devel
WORKDIR /usr/local/src/
RUN wget http://cn2.php.net/distributions/php-7.2.5.tar.gz
RUN tar zxvf php-7.2.5.tar.gz
WORKDIR php-7.2.5
RUN ./configure \
--prefix=/opt/php7.2.5 \
--with-curl \
--with-freetype-dir \
--with-gd \
--with-gettext \
--with-iconv-dir \
--with-kerberos \
--with-libdir=lib64 \
--with-libxml-dir \
--with-mysqli \
--with-openssl \
--with-pcre-regex \
--with-pdo-mysql \
--with-pdo-sqlite \
--with-pear \
--with-png-dir \
--with-xmlrpc \
--with-xsl \
--with-zlib \
--enable-bcmath \
--enable-libxml \
--enable-inline-optimization \
--enable-gd-native-ttf \
--enable-mbregex \
--enable-mbstring \
--enable-opcache \
--enable-pcntl \
--enable-shmop \
--enable-soap \
--enable-sockets \
--enable-sysvsem \
--enable-xml \
--enable-zip \
--with-apxs2 \
--with-jpeg-dir
RUN make && make install
COPY ./php.ini /opt/php7.2.5/lib/php.ini
RUN mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak
COPY ./httpd.conf /etc/httpd/conf/
RUN systemctl enable httpd
COPY ./test.php /var/www/html/
RUN chown apache. -R /var/www/html
ENV PATH /opt/php7.2.5/bin:$PATH
