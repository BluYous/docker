#!/bin/bash
set -e
set -o pipefail
if [ ! -e "/FILE__STATIC_RESOURCE_HOST" ]; then
  echo "/FILE__STATIC_RESOURCE_HOST does not exist!"
  exit 1
fi
STATIC_RESOURCE_HOST="$(cat "/FILE__STATIC_RESOURCE_HOST")"
rm -f "/FILE__STATIC_RESOURCE_HOST"
# update LANG and time zone
{
  echo 'LANG="C.UTF-8"'
  echo 'LC_ALL="C.UTF-8"'
  echo 'TZ="Asia/Shanghai"'
} >>/etc/environment
#ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# install fonts
apt-get update
apt-get install -y fonts-noto

# Utilities
apt-get install -y nano \
  git \
  wget \
  unzip \
  xz-utils \
  iputils-ping \
  iproute2 \
  qdirstat

# IDEA
download_url=$(curl -fsSL --retry 10 --retry-all-errors --retry-connrefused "https://data.services.jetbrains.com/products/releases?code=IIU&latest=true&type=release" | jq -r ".IIU[0].downloads.linux.link")
curl -fsSL "$download_url" | tar -zxC "/opt"
mv "$(ls -dt "/opt/idea-IU-"*)" "/opt/idea-IU"
sed -i -E "s/# idea.config.path=\\$\{user.home}\/.IntelliJIdea\/config/idea.config.path=\/config\/.config\/JetBrains\/IntelliJIdea/g" /opt/idea-IU/bin/idea.properties
sed -i -E "s/# idea.system.path=\\$\{user.home}\/.IntelliJIdea\/system/idea.system.path=\/config\/.cache\/JetBrains\/IntelliJIdea/g" /opt/idea-IU/bin/idea.properties
sed -i -E "s/# idea.plugins.path/idea.plugins.path/g" /opt/idea-IU/bin/idea.properties
sed -i -E "s/# idea.log.path/idea.log.path/g" /opt/idea-IU/bin/idea.properties
curl -fsSL "$STATIC_RESOURCE_HOST/soft/jetbra.zip" -o "/tmp/jetbra.zip"
unzip "/tmp/jetbra.zip" -d "/opt/idea-IU"
{
  echo '-javaagent:/opt/idea-IU/jetbra/ja-netfilter.jar=jetbrains'
  echo '--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED'
  echo '--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED'
} >>"/opt/idea-IU/bin/idea64.vmoptions"

# NodeJS
curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs
npm install --global yarn

# Install JDK
apt-get install -y openjdk-17-jdk

# Beyond Compare
download_url=$(curl -fsSL "https://www.scootersoftware.com/download" | grep -oE '/files/[^"]+amd64\.deb' | sed -n 1p)
curl -fsSL -q "https://www.scootersoftware.com$download_url" -o "/tmp/bcompare.deb"
apt-get install -y '/tmp/bcompare.deb'

# GoldenDict
download_url=$(curl -fsSL --retry 10 --retry-all-errors --retry-connrefused "https://api.github.com/repos/xiaoyifang/goldendict-ng/releases/latest" | jq -r ".assets[].browser_download_url" | grep "AppImage" | sed -n '$p')
curl -fsSL -q "$download_url" -o "/tmp/GoldenDict.AppImage"
chmod +x '/tmp/GoldenDict.AppImage'
'/tmp/GoldenDict.AppImage' --appimage-extract
mv ./squashfs-root /opt/GoldenDict
ln -s /usr/lib/x86_64-linux-gnu/nss/* /opt/GoldenDict/usr/lib/
sed -i '2i export QTWEBENGINE_DISABLE_SANDBOX=1' /opt/GoldenDict/AppRun

# PeaZip
download_url=$(curl -fsSL --retry 10 --retry-all-errors --retry-connrefused "https://api.github.com/repos/peazip/PeaZip/releases/latest" | jq -r ".assets[].browser_download_url" | grep -i "Qt.*amd64\.deb")
curl -fsSL -q "$download_url" -o "/tmp/peazip.deb"
apt-get install -y libqt5printsupport5 libqt5x11extras5
apt-get install -y '/tmp/peazip.deb'

# 搜狗输入法
apt install -y fcitx
cp /usr/share/applications/fcitx.desktop /etc/xdg/autostart/
apt install -y libqt5qml5 libqt5quick5 libqt5quickwidgets5 qml-module-qtquick2 libgsettings-qt1
download_url=$(curl -fsSL --retry 10 --retry-all-errors --retry-connrefused "https://shurufa.sogou.com/linux" | grep -oE 'https[^"]+amd64\.deb')
curl -fsSL -q "$download_url" -o "/tmp/sogoupinyin.deb"
apt-get install -y '/tmp/sogoupinyin.deb'
{
  echo 'GTK_IM_MODULE="fcitx"'
  echo 'QT_IM_MODULE="fcitx"'
  echo 'XMODIFIERS="@im=fcitx"'
} >>/etc/environment

# remove cache
apt-get autoclean &&
  rm -rf \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*
