Felix' Salt States
==================
If you use the ssh state, then my public key will be registered for root on
your server.

The following is for a masterless setup.

Ubuntu 14.04

.. code:: bash

    sudo -i
    add-apt-repository -- yes ppa:saltstack/salt
    apt-get update
    apt-get --yes install git salt-minion

    cat <<EOF > /etc/salt/minion
    file_client: local
    state_verbose: False
    file_roots:
      base:
        - /srv/salt
        - /srv/felix.salt
    EOF
    # stop salt-minion for local
    service salt-minion stop

    # Base env
    mkdir -p /srv/salt

    # Clone
    git clone https://github.com/felixhummel/saltstates /srv/felix.salt

    # Base top file
    cp /srv/felix.salt/base_top_example.sls /srv/salt/top.sls

    # Run locally
    salt-call state.highstate

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

