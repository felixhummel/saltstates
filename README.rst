Felix' Salt States
==================
If you use the ssh state, then my public key will be registered for root on
your server.

The following is for a masterless setup.

Ubuntu 14.04

.. code:: bash

    sudo -i
    add-apt-repository --yes ppa:saltstack/salt
    apt-get update
    apt-get --yes install git salt-minion
    cat <<EOF > /etc/salt/minion
    file_client: local
    state_verbose: False
    file_roots:
      base:
        - /srv/salt/base
        - /srv/salt/felix
    EOF
    # stop salt-minion for local
    service salt-minion stop

Base env

.. code:: bash

    mkdir -p /srv/salt
    test ! -d /srv/salt/base && git init /srv/salt/base

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

    git clone https://github.com/felixhummel/saltstates /srv/salt/felix

Base top file

.. code:: bash

    cp /srv/salt/felix/base_top_example.sls /srv/salt/base/top.sls

Run locally

.. code:: bash

    salt-call state.highstate


