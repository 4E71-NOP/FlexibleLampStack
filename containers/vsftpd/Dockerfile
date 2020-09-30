FROM debian:latest

# https://github.com/moby/moby/issues/4032#issuecomment-192327844
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update --no-install-recommends --fix-missing

RUN apt-get install --no-install-recommends --fix-missing -y \
    apt-utils \
    build-essential 

RUN apt-get install --no-install-recommends --fix-missing -y \
	vsftpd \
	net-tools

#	--------------------------------------------------------------------
#	FTP 
RUN useradd flexible -b /var/www/html/ -d /var/www/html/ -u 1000 

RUN usermod flexible -G ftp
RUN usermod flexible -G www-data
RUN echo "flexible:flexible" | chpasswd 

RUN cat /etc/vsftpd.conf
RUN cat /etc/vsftpd.chroot_list
