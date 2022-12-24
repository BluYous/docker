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
