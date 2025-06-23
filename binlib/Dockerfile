FROM       ubuntu
ENV        EDITOR=nano
RUN         apt-get update && \
            DEBIAN_FRONTEND=noninteractive && \
            apt-get install --no-install-recommends -y nodejs npm curl nano qemu-utils && \
            npm install -g bestroutetb && \
            apt-get autoclean && \
            curl -fsSL https://raw.githubusercontent.com/vanchKong/cloudflare/refs/heads/main/cfst.sh -o /opt/cfst/cfst.sh \
            rm -rf \
              /config/.cache \
              /var/lib/apt/lists/* \
              /var/tmp/* \
              /tmp/*
CMD        ["sleep", "infinity"]
