set -ex;
curl -L $1 -o /tmp/GoldenDict.AppImage;
chmod +x /tmp/GoldenDict.AppImage;
cd /opt;
/tmp/GoldenDict.AppImage --appimage-extract;
mv ./squashfs-root ./GoldenDict
rm -rf /tmp/GoldenDict.AppImage
