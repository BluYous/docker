FROM       docker
ENV        EDITOR=nano
RUN        apk add --no-cache nodejs npm git curl perl bash perl-pathtools tar procps nano tini python3 qemu-img \
                && npm install -g bestroutetb \
                && bestroutetb --update
WORKDIR    /
ENTRYPOINT ["/sbin/tini", "--"]
CMD        ["sh", "sleep", "infinity"]
