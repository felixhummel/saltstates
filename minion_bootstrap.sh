#!/bin/bash
set -euo pipefail

if [[ -f /etc/salt/minion ]]; then
  if sha256sum -c <(echo "f1db6712c971b9db28f84d5b3ea2b3b1ec1fc2e09265b30d21336e95e7ed5332  /etc/salt/minion"); then
    echo "nothing to do"
    exit 0
  fi
  sudo cp /etc/salt/minion /etc/salt/minion.bak
fi

# masterless
sudo tee /etc/salt/minion <<EOF
file_client: local
# print changes only
state_verbose: False
EOF

sudo service salt-minion restart
