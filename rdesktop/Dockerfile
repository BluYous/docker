FROM linuxserver/rdesktop:ubuntu-xfce
COPY "./src/*" "/tmp/"
RUN bash "/tmp/install.sh" && rm -f "/tmp/install.sh"
