FROM linuxserver/rdesktop:ubuntu-xfce
ARG STATIC_RESOURCE_HOST
COPY "./src/install.sh" "/tmp/"
RUN bash "/tmp/install.sh" "$STATIC_RESOURCE_HOST" && rm -f "/tmp/install.sh"
