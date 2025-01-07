FROM ubuntu
ENV EDITOR=nano
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive
RUN apt-get install --no-install-recommends -y nodejs npm curl nano qemu-img
RUN npm install -g bestroutetb
RUN bestroutetb --update
RUN apt-get autoclean
RUN rm -rf \
  /config/.cache \
  /var/lib/apt/lists/* \
  /var/tmp/* \
  /tmp/*

CMD        ["sleep", "infinity"]
