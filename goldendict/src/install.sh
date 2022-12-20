set -ex;
DOWNLOAD_URL=$(curl -sX GET "https://api.github.com/repos/xiaoyifang/goldendict/releases?per_page=1" \
    | awk '/"browser_download_url": ".*6\.4\..*AppImage"/{print $4;exit}' FS='[""]');
curl -L ${DOWNLOAD_URL} -o /tmp/GoldenDict.AppImage;
chmod +x /tmp/GoldenDict.AppImage;
cd /;
/tmp/GoldenDict.AppImage --appimage-extract && mv /squashfs-root /GoldenDict
