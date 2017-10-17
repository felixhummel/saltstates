Felix' Salt States
==================
The following is for a masterless_ setup.

.. _masterless: https://docs.saltstack.com/en/latest/topics/tutorials/quickstart.html

Install Salt on Ubuntu 16.04 (`others <https://repo.saltstack.com/>`__)::

    curl https://raw.githubusercontent.com/felixhummel/saltstates/master/bin/masterless.sh | sudo -i bash

See [bin/masterless.sh](bin/masterless.sh).


Default
-------
::

    cat << 'EOF' > /etc/salt/minion
    # https://docs.saltstack.com/en/latest/ref/output/all/salt.output.highstate.html
    state_verbose: False
    state_output: changes

    file_client: local
    file_roots:
      base:
        - /srv/salt
      felix:
        - /srv/felix.salt

    top_file_merging_strategy: same
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
