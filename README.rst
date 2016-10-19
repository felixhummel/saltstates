Felix' Salt States
==================
The following is for a masterless_ setup.

.. _masterless: https://docs.saltstack.com/en/latest/topics/tutorials/quickstart.html

Install Salt on Ubuntu 16.04 (`others <https://repo.saltstack.com/>`__)::

    sudo -i

    # prevent salt-minion from starting
    # http://askubuntu.com/a/501622
    cat <<EOF > /usr/sbin/policy-rc.d
    #!/bin/sh
    echo "All runlevel operations denied by policy" >&2
    exit 101
    EOF

    wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
    echo 'deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main' > /etc/apt/sources.list.d/saltstack.list
    apt-get update
    apt-get --yes install git salt-minion

    # disable salt-minon
    sudo systemctl disable salt-minion.service


Felix' setup::

    cat << 'EOF' > /etc/salt/minion
    # https://docs.saltstack.com/en/latest/ref/output/all/salt.output.highstate.html
    state_verbose: False
    state_output: changes

    file_client: local
    file_roots:
      base:
        - /srv/salt
        - /srv/private.salt
    EOF

    git clone https://github.com/felixhummel/saltstates /srv/salt
    cp -r /srv/salt/examples/pillar /srv/pillar
    # private state is included in desktop, make sure it exists
    mkdir -p /srv/private.salt
    touch /srv/private.salt/private.sls

    salt-call grains.get id
    salt-call pillar.get users


On a server to include some of these states::

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

Jiffybox

.. code:: bash

    # backup
    mkdir /var/backups/etc
    cp /etc/hosts /var/backups/etc/
    cp /etc/hostname /var/backups/etc/

    box=foo
    cat <<EOF > /etc/hosts
    127.0.0.1       $box.felixhummel.de $box
    ::1             localhost6.localdomain6 localhost6
    127.0.0.1       localhost
    ::1             localhost ip6-localhost ip6-loopback
    ff02::1         ip6-allnodes
    ff02::2         ip6-allrouters
    EOF
    echo $box > /etc/hostname
    hostname $box

    # to see the changes
    exec $SHELL
    hostname
    hostname -f

    rm /etc/salt/minion_id
    salt-call grains.get id
