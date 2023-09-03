#!/bin/bash
set -e
set -o pipefail

apk update
apk add --no-cache jq py3-pip qemu-img
npm install -g bestroutetb he
pip install csvkit
