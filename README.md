#Download the image first
docker pull taozhenting/centos7:nginx-php7.0.27-0.1
docker pull taozhenting/centos7:mysql5.7.21-0.1
docker tag taozhenting/centos7:nginx-php7.0.27-0.1 moodle-nginx-php7.0:0.1
docker tag taozhenting/centos7:mysql5.7.21-0.1 moodle-mysql5.7:0.1
docker rmi taozhenting/centos7:nginx-php7.0.27-0.1
docker rmi taozhenting/centos7:mysql5.7.21-0.1

#build image
useradd nginx
mkdir -p /usr/share/nginx/html/moodle
mkdir -p /usr/share/nginx/html/moodledata
chown nginx. -R /usr/share/nginx/html
docker-compose up -d

#upload moodle
#download https://download.moodle.org/releases/latest/
tar zxvf  moodle-latest-34.tgz
mv -f moodle /usr/share/nginx/html/
chown nginx. -R /usr/share/nginx/html

#install moodle
#http://ip/

#nginx configure config.php
cd /usr/share/nginx/html/moodle
vi config.php
$CFG->slasharguments = false;
