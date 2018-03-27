FROM moodle-nginx-php7.0:0.1
MAINTAINER tom.tao
COPY ./moodle-latest-34.tgz /usr/local/src/
RUN mkdir /usr/share/nginx/html/moodledata
RUN usermod -u 1000 nginx
RUN chown nginx. -R /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/
RUN mv -f /opt/php7.0.27/lib/php.ini /opt/php7.0.27/lib/php.ini.bak
COPY ./php.ini /opt/php7.0.27/lib/
RUN mv -f /opt/php7.0.27/etc/php-fpm.d/www.conf /opt/php7.0.27/etc/php-fpm.d/www.conf.bak
COPY ./www.conf /opt/php7.0.27/etc/php-fpm.d/
RUN systemctl enable nginx
RUN yum install -y icu libicu libicu-devel  glibc-headers  gcc-c++
WORKDIR /usr/local/src/php-7.0.27/ext/intl/
RUN /opt/php7.0.27/bin/phpize
RUN ./configure --with-php-config=/opt/php7.0.27/bin/php-config
RUN make
RUN make install
