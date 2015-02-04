Felix' Salt States
==================
If you use the ssh state, then my public key will be registered for root on
your server.

Kubuntu 14.10 fresh::

    sudo -i
    add-apt-repository ppa:saltstack/salt
    apt-get update
    apt-get install git salt-minion

Clone::

    git clone https://github.com/felixhummel/saltstates /srv/salt

Run locally::

    salt-call --local state.highstate

