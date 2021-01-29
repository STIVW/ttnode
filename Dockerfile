FROM ubuntu
MAINTAINER stivw <869862584@qq.com>

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN apt update && \
    apt install	-y openssh-server && \
    echo "root:123456" | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
    mkdir -p /var/run/sshd

RUN apt install python3 -y &&\
    apt install python3-pip -y &&\
    apt install git -y &&\
	git clone https://github.com/744287383/AutomationTTnode.git

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata
	
RUN apt-get install -y  cron vim
COPY tt-cron /etc/cron.d/tt-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/tt-cron
# Apply cron job
RUN crontab /etc/cron.d/tt-cron
# Create the log file to be able to run tail
RUN touch /var/log/cron.log

#Install supervisor
RUN apt install supervisor -y

#Install rsyslog
RUN apt-get install rsyslog -y && \
    sed -i "s/#cron.*/cron.*/g" /etc/rsyslog.d/50-default.conf 


EXPOSE 22

#CMD ["/usr/sbin/sshd","-D"]

CMD ["/usr/bin/supervisord"]


