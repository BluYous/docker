set -ex;
curl -L $1 -o /tmp/GoldenDict.AppImage;
chmod +x /tmp/GoldenDict.AppImage;
cd /;
/tmp/GoldenDict.AppImage --appimage-extract;
mv /squashfs-root /GoldenDict
