FROM ubuntu
MAINTAINER stivw <869862584@qq.com>

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY tt-cron /etc/cron.d/tt-cron

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

RUN apt update && \
    apt install	-y openssh-server  python3  python3-pip git cron vim supervisor rsyslog && \
    echo "root:123456" | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
    mkdir -p /var/run/sshd && \
    git clone https://github.com/744287383/AutomationTTnode.git && \
    sed -i "s/#cron.*/cron.*/g" /etc/rsyslog.d/50-default.conf  && \
    chmod 0644 /etc/cron.d/tt-cron && \
    crontab /etc/cron.d/tt-cron && \
    touch /var/log/cron.log && \
    apt-get clean && \
    apt-get purge -y --auto-remove

	

EXPOSE 22
 
CMD ["/usr/bin/supervisord"]


