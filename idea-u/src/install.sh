set -ex
cd /tmp
wget -q $1 -O - | tar -xz
find . -maxdepth 1 -type d -name * -execdir mv {} /opt/idea-u \;
sed -i -E "s/# idea.config.path=\\$\{user.home}\/.IntelliJIdea\/config/idea.config.path=\/config\/config/g" /opt/idea-u/bin/idea.properties
sed -i -E "s/# idea.system.path=\\$\{user.home}\/.IntelliJIdea\/system/idea.system.path=\/config\/system/g" /opt/idea-u/bin/idea.properties
sed -i -E "s/# idea.plugins.path/idea.plugins.path/g" /opt/idea-u/bin/idea.properties
sed -i -E "s/# idea.log.path/idea.log.path/g" /opt/idea-u/bin/idea.properties
mkdir /config
chown -R 1000:0 /config
chmod 666 /opt/idea-u/bin/idea64.vmoptions

# Install PowerShell
# Update the list of packages
apt-get update
# Install pre-requisite packages.
apt-get install -y wget apt-transport-https software-properties-common
# Download the Microsoft repository GPG keys
wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
# Register the Microsoft repository GPG keys
dpkg -i packages-microsoft-prod.deb
# Update the list of packages after we added packages.microsoft.com
apt-get update
# Install PowerShell
apt-get install -y powershell

# Install JDK 
apt-get install -y openjdk-17-jdk
