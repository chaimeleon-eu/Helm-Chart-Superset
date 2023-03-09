FROM harbor.chaimeleon-eu.i3m.upv.es/chaimeleon-library/bahia-software/superset:latest

############## Things done by the root user ##############
USER root

ENV DEBIAN_FRONTEND noninteractive
RUN apt update && \
    apt install -y --no-install-recommends \
                software-properties-common curl apache2-utils && \
    apt install -y --no-install-recommends \
                supervisor net-tools zenity xz-utils \
                dbus-x11 x11-utils alsa-utils mesa-utils libgl1-mesa-dri && \
    apt install -y --no-install-recommends \
                xvfb x11vnc vim-tiny wget less firefox-esr ttf-wqy-zenhei  && \
    apt install -y --no-install-recommends \
                lxde gtk2-engines-murrine gnome-themes-standard \
                gtk2-engines-pixbuf gtk2-engines-murrine arc-theme openssh-server && \
    rm -rf /var/lib/apt/lists/*
    
# tini to fix subreap
ARG TINI_VERSION=v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini

COPY rootfs/etc /etc/
COPY rootfs/usr /usr/ 
COPY --chown=superset:superset rootfs/home/chaimeleon /home/chaimeleon/
RUN chmod +x /home/chaimeleon/.init/startup.sh && \
    chmod +x /home/chaimeleon/.init/configure_sshd.sh && \
    chmod +x /usr/local/bin/xvfb.sh

# Default password "chaimeleon" for superset user
# (setting the password is required if we want to install sshd and login with that user)
RUN echo "superset:chaimeleon" | chpasswd

RUN pip3 install --no-cache-dir guacli

EXPOSE 5900
EXPOSE 2222

############### Now change to normal user ################
USER superset:superset
WORKDIR /home/chaimeleon

ENV SUPERVISOR_CONF_FILE=/home/chaimeleon/.supervisor/conf.d/supervisord.conf
RUN mkdir -p /home/chaimeleon/.supervisor/conf.d/ && \
    cp /etc/supervisor/conf.d/supervisord.conf $SUPERVISOR_CONF_FILE

# default values to environment variables which can be configured
ENV VNC_HOST= \
    VNC_PASSWORD= \
    PASSWORD= \
    X11VNC_ARGS= \
    OPENBOX_ARGS= \
    RESOLUTION= \
    GUACAMOLE_URL= \
    GUACAMOLE_USER= \
    GUACAMOLE_PASSWORD= \
    GUACD_HOST= \
    GUACAMOLE_CONNECTION_NAME=

########## SSH service default values to environment variables which can be configured
ENV SSH_ENABLE_PASSWORD_AUTH= \
    TCP_FORWARDING= \
    GATEWAY_PORTS= \
    DISABLE_SFTP=
    
ENTRYPOINT ["/home/chaimeleon/.init/startup.sh"]

