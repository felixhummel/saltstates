users:

  root:
    name: I AM ROOT
    email: obey@example.org
    configs_repo: https://github.com/felixhummel/configs.git
    cleanup_home: True

  alice:  # this is the unix username
    name: Alice Wonderland
    email: alice@example.org
    # the following are optional
    admin: True
    pyenv: True
    uid: 1336
    gid: 1336
    password_hash: $6$1FjND5Ll$oiCbLFnHE.qfH0VePdMu16V.Ehktl7QjRPChScvbOX8o1pdnQ6a2W3nmRa9nN7TiOvLcn9Buak.2JpFkoh8gE1
    known_hosts:
      # fetch keys with ``ssh-keyscan -t rsa $HOSTNAME``
      github.com: AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==

