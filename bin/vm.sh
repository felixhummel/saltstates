#!/bin/bash
# Enabling best practices :>
#
#   curl https://raw.githubusercontent.com/felixhummel/saltstates/master/bin/vm.sh | sudo -i bash
#
set -euo pipefail

if [[ $UID != 0 ]]; then
  echo "Run me as root, e.g."
  echo "  curl https://raw.githubusercontent.com/felixhummel/saltstates/master/bin/vm.sh | sudo -i bash"
  exit 1
fi

set -x

wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
echo 'deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main' > /etc/apt/sources.list.d/saltstack.list
apt-get update
apt-get --yes install git salt-minion

service salt-minion stop

cat << 'EOF' > /etc/salt/minion
# https://docs.saltstack.com/en/latest/ref/output/all/salt.output.highstate.html
state_verbose: False
state_output: changes

file_client: local
file_roots:
  base:
    - /srv/salt
    - /srv/felix.salt
EOF

git clone https://github.com/felixhummel/saltstates /srv/felix.salt

cp -r /srv/felix.salt/examples/salt /srv/salt
touch /srv/salt/private.sls
cp -r /srv/felix.salt/examples/pillar /srv/pillar

salt-call grains.get id
salt-call pillar.get users

