FROM linuxserver/rdesktop:ubuntu-xfce
COPY root/tmp /tmp
COPY root/usr /usr
RUN bash "ls /tmp -dlah"
RUN bash "ls /tmp -lah"
RUN bash "exit 1"
#RUN bash "/tmp/install.sh" && rm -f "/tmp/install.sh"
