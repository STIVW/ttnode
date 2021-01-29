FROM ubuntu
MAINTAINER stivw <869862584@qq.com>

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN apt update && \
    apt-get install -y  cron vim supervisor  rsyslog

RUN apt install python3 -y &&\
    apt install python3-pip -y &&\
    apt install git -y &&\
    git clone https://github.com/744287383/AutomationTTnode.git

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata	
    
COPY tt-cron /etc/cron.d/tt-cron

# Give execution rights on the cron job
# Apply cron job
# Create the log file to be able to run tail
RUN chmod 0644 /etc/cron.d/tt-cron &&\
    crontab /etc/cron.d/tt-cron &&\
    touch /var/log/cron.log &&\
    sed -i "s/#cron.*/cron.*/g" /etc/rsyslog.d/50-default.conf


CMD ["/usr/bin/supervisord"]


