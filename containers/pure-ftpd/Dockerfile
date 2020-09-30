FROM debian:latest

# https://github.com/moby/moby/issues/4032#issuecomment-192327844
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update --no-install-recommends --fix-missing

RUN apt-get install --no-install-recommends --fix-missing -y \
    apt-utils \
	pure-ftpd

RUN useradd flexible -b /var/www/html/ -d /var/www/html/ -u 1000
RUN usermod flexible -G www-data
RUN echo "flexible:flexible" | chpasswd 

ENTRYPOINT ["pure-ftpd"]
CMD ["/etc/pure-ftpd/pure-ftpd.conf"]
