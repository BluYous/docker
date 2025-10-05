FROM linuxserver/qbittorrent
COPY --from=ghcr.io/vuetorrent/vuetorrent-lsio-mod / /
COPY --from=linuxserver/mods:universal-stdout-logs / /
ENV LOGS_TO_STDOUT="/config/qBittorrent/logs/qbittorrent.log"
