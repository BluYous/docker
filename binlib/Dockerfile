FROM       ubuntu
ENV        EDITOR=nano
RUN         apt-get update && \
            DEBIAN_FRONTEND=noninteractive && \
            apt-get install --no-install-recommends -y nodejs npm curl wget nano qemu-utils jq moreutils && \
            npm install -g bestroutetb && \
            apt-get autoclean && \
            mkdir -p '/opt/cfst' && \
            curl -fsSL 'https://raw.githubusercontent.com/vanchKong/cloudflare/refs/heads/main/cfst.sh' -o '/opt/cfst/cfst.sh' && \
            chmod +x '/opt/cfst/cfst.sh' && \
            mkdir -p '/config/cfst' && \
            touch '/config/cfst/hosts' && \
            sed -i 's|/etc/hosts|/config/cfst/hosts|g' '/opt/cfst/cfst.sh' && \
            sed -i -E 's/sed -i (.*) ([\/A-Za-z0-9]+$)/sed \1 \2 | sponge \2/' '/opt/cfst/cfst.sh' && \
            echo 1 | bash /opt/cfst/cfst.sh && \
            cp '/config/cfst/hosts' '/config/cfst/hosts.example' && \
            rm -rf \
              /config/.cache \
              /var/lib/apt/lists/* \
              /var/tmp/* \
              /tmp/*
CMD        ["sleep", "infinity"]
