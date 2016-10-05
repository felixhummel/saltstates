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
    # added to ~/.ssh/authorized_keys
    pubkeys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCV72T/8iglTiB7QlzUF4JWk8i2y7g0UlZ2m941gBfIIF9AEPnjSfynqvRjTWWWnd8TtE4MnIiKwCkg5Vkh5jHFO4DTWMX2FQZzZHsGfUL4V0TcwzBAXw3uLo0kCx3YIH0Vy/NMX/5lgLWsr2Ubp1OM2P8UNkOlpK/rUwepqoaGz9ATMq0LQ7VsiVQjx7qRpkEEffHY4e98H35q6w68fqis9/tXkJGkLbK0zBlvOftg/BRDU3c5YvTqroeSkIJuJXl0bImFBzxE3chGVJ8aK+xt4i+rbKlam6J3Uo2P5o1UPccjBJTZntuB8kzfoYtGvN+NHkGlhGLe6gu349s7EXwkEKFUJDrItMPddlH5JmJGMGKznQ8ntKT4G0UtNh2ze43qTF+wmMqUqxrW5pek0RFe4u68wi2B61mfwUHbp10N553wS+vjmfAZdjTiryVesQ1pwZhixxsuAtn3PsZGEiXTmXpSnW1/ljBiDJxLxldQjVnrahLnW4RNdvvdr3X1ebWJKAqo6xYZqwJGOROV4lXa6uN0JzP5RMsVzR5LLTSuBrjYQvZVS3BHEICohjB0QUTReGjt1qXX/ZvQIlby2bK28Rayiq7Dkomls6a+8gpOHjqMPA8eWpxw/Kc2RaDTyr0O8nTClfctbQqwrA50z46WCu6sB5iUbYDLW6Y+ijgTMw== alice@wonderland

