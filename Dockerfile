FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y apache2 curl bc \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /app/backups /app/logs /app/evidencias /app/biblioteca-digital

WORKDIR /app
COPY scripts /app/scripts
COPY source /app/source
RUN chmod +x /app/scripts/*.sh

EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
