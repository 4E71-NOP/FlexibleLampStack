FROM debian:latest

# https://github.com/moby/moby/issues/4032#issuecomment-192327844
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update --no-install-recommends --fix-missing

RUN apt-get install --no-install-recommends --fix-missing -y \
    apt-utils \
	vsftpd
    # build-essential 

# RUN apt-get install --no-install-recommends --fix-missing -y \
	# openssl
	# db4-utils \
	# db4 \
	# iproute	
	# net-tools
#	--------------------------------------------------------------------
#	FTP 
# COPY vsftpd.conf /etc/vsftpd.conf

RUN mkdir -p /home/vsftpd/
RUN chown -R ftp:ftp /home/vsftpd/
RUN mkdir -p /home/flexible/
RUN chown -R ftp:ftp /home/flexible/

RUN useradd flexible -b /var/www/html/ -d /var/www/html/ -u 1000
# RUN usermod flexible -G ftp
RUN usermod flexible -G www-data
RUN echo "flexible:flexible" | chpasswd 
RUN echo "flexible" >> /etc/vsftpd.chroot_list

EXPOSE 21 40000-40100 

RUN more /etc/passwd
RUN more /etc/vsftpd.conf
RUN more /etc/vsftpd.chroot_list
RUN echo "log" >> /var/log/vsftpd.log


ENTRYPOINT ["vsftpd"]
CMD ["/etc/vsftpd.conf"]

# RUN more /etc/vsftpd.conf
# RUN more /etc/vsftpd.chroot_list
# RUN /usr/sbin/vsftpd /etc/vsftpd.conf
