# http://docs.saltstack.com/en/latest/ref/states/all/salt.states.mount.html#module-salt.states.mount
# some options borrowed from https://github.com/saltstack/salt/issues/16618
/tmp/x:
  mount.mounted:
    - device: sshfs#enterprise:/tmp
    - fstype: fuse
    - opts: defaults,reconnect,nobootwait,sshfs_sync
    - mkmnt: True
    - user: felix
