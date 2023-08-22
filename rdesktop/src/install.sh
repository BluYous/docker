#!/bin/bash
set -e
set -o pipefail
if [ ! -e FILE__STATIC_RESOURCE_HOST ]; then
  echo "FILE__STATIC_RESOURCE_HOST does not exist!"
  exit 1
fi
STATIC_RESOURCE_HOST="$(cat /tmp/FILE__STATIC_RESOURCE_HOST)"
rm -f /tmp/FILE__STATIC_RESOURCE_HOST
# Update repositories
curl -fsSL "https://raw.githubusercontent.com/linuxserver/docker-mods/universal-internationalization/root/etc/s6-overlay/s6-rc.d/init-mod-universal-internationalization-install/run" | bash -

# Utilities
apt-get install -y nano
apt-get install -y git
apt-get install -y wget
apt-get install -y unzip
apt-get install -y iputils-ping iproute2

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

# Install JDK
apt-get install -y openjdk-17-jdk

# Beyond Compare
download_url=$(curl -fsSL "https://www.scootersoftware.com/download" | grep -oE '/files/[^"]+amd64\.deb' | sed -n 1p)
curl -fsSL -q "https://www.scootersoftware.com$download_url" -o "/tmp/bcompare.deb"
apt-get install -y '/tmp/bcompare.deb'

apt-get autoclean &&
  rm -rf \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*
