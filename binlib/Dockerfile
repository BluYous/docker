FROM       ubuntu
ENV        EDITOR=nano
RUN         apt-get update && \
            DEBIAN_FRONTEND=noninteractive && \
            apt-get install --no-install-recommends -y nodejs npm curl nano qemu-utils && \
            npm install -g bestroutetb && \
            bestroutetb --update && \
            apt-get autoclean && \
            rm -rf \
              /config/.cache \
              /var/lib/apt/lists/* \
              /var/tmp/* \
              /tmp/*
CMD        ["sleep", "infinity"]
