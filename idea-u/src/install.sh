set -ex
cd /tmp
wget -q $1 -O - | tar -xz
find . -maxdepth 1 -type d -name * -execdir mv {} /opt/idea-u \;
