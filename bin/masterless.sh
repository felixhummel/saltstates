#!/bin/bash
set -euo pipefail

set -x

[[ $(id -u) == 0 ]]

cat <<EOF > /usr/sbin/policy-rc.d
#!/bin/sh
echo "All runlevel operations denied by policy" >&2
exit 101
EOF
chmod +x /usr/sbin/policy-rc.d

curl -L https://bootstrap.saltstack.com | sh

# disable salt-minon
systemctl disable salt-minion.service
# enable daemon starting again
rm /usr/sbin/policy-rc.d
