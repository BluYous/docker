#!/bin/bash
set -e
set -o pipefail

apk update
# bind-tools contains dig
apk add --no-cache jq py3-pip qemu-img bind-tools
npm install -g bestroutetb he
pip install csvkit
bestroutetb --update

# install mmdbinspect
curl -fsSL "$(curl -fsSL -q "https://api.github.com/repos/maxmind/mmdbinspect/releases/latest" | jq -r ".assets[].browser_download_url" | grep "linux_amd64\.tar\.gz")" | tar -zxC "/tmp" --wildcards mmdbinspect*/mmdbinspect
mv /tmp/mmdbinspect*/mmdbinspect /usr/local/bin/
rm -rf /tmp/mmdbinspect*
