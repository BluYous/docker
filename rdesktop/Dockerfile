FROM linuxserver/rdesktop:ubuntu-xfce
COPY root/tmp /tmp
COPY root/usr /usr
RUN bash "/tmp/install.sh" && rm -f "/tmp/install.sh"
