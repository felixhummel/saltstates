Felix' Salt States
==================
The following is for a masterless_ setup.

.. _masterless: https://docs.saltstack.com/en/latest/topics/tutorials/quickstart.html

Install Salt via https://bootstrap.saltstack.com::

    curl https://raw.githubusercontent.com/felixhummel/saltstates/master/bin/masterless.sh | sudo -i bash

See [bin/masterless.sh](bin/masterless.sh).


Default (Debian 9)
------------------
::

    sudo -i
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

