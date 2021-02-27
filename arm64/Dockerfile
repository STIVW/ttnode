FROM arm64v8/ubuntu
MAINTAINER stivw <869862584@qq.com>

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY tt-cron /etc/cron.d/tt-cron

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

RUN apt update && \
    apt install	-y git wget cron vim supervisor rsyslog curl ca-certificates jq -y --no-install-recommends && \
    sed -i "s/#cron.*/cron.*/g" /etc/rsyslog.d/50-default.conf  && \
    chmod 0644 /etc/cron.d/tt-cron && \
    crontab /etc/cron.d/tt-cron && \
    touch /var/log/cron.log && \
    mkdir -p /usr/node &&\
    cd /usr/node &&\
    wget https://cdn.jsdelivr.net/gh/ericwang2006/docker_ttnode/build_dir/ttnode_task.sh &&\
    chmod 777 /usr/node/ttnode_task.sh &&\
    apt-get clean && \
    apt-get purge -y --auto-remove

 
CMD ["/usr/bin/supervisord"]
