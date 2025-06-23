FROM       ubuntu
ENV        EDITOR=nano
RUN         apt-get update && \
            DEBIAN_FRONTEND=noninteractive && \
            apt-get install --no-install-recommends -y nodejs npm curl wget nano qemu-utils && \
            npm install -g bestroutetb && \
            apt-get autoclean && \
            wget -q -O /opt/cfst/cfst.sh https://raw.githubusercontent.com/vanchKong/cloudflare/refs/heads/main/cfst.sh \
            rm -rf \
              /config/.cache \
              /var/lib/apt/lists/* \
              /var/tmp/* \
              /tmp/*
CMD        ["sleep", "infinity"]
