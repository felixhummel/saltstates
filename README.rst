Felix' Salt States
==================
If you use the ssh state, then my public key will be registered for root on
your server.

Kubuntu 14.10 fresh

.. code:: bash

    sudo -i
    add-apt-repository ppa:saltstack/salt
    apt-get update
    apt-get --yes install git salt-minion
    cat <<EOF > /etc/salt/minion
    file_client: local
    state_verbose: False
    EOF

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

Clone

.. code:: bash

    git clone https://github.com/felixhummel/saltstates /srv/salt

Run locally

.. code:: bash

    salt-call state.highstate


