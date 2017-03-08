#!/bin/bash
set -euo pipefail

set -x

[[ $(id -u) == 0 ]]

cat <<EOF > /usr/sbin/policy-rc.d
#!/bin/sh
echo "All runlevel operations denied by policy" >&2
exit 101
EOF

wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo 'deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main' > /etc/apt/sources.list.d/saltstack.list
apt-get update && apt-get --yes install git salt-minion

# disable salt-minon
systemctl disable salt-minion.service
# enable daemon starting again
rm /usr/sbin/policy-rc.d
