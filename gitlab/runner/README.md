# Initial Setup
```
cat <<EOF > /srv/pillar/gitlab-runner.sls
gitlab-runner:
  CI_SERVER_URL: https://git.example.org/
  REGISTRATION_TOKEN: XXX
EOF
vi /srv/pillar/gitlab-runner.sls

vi /srv/pillar/top.sls  # add 'gitlab-runner'
```


# Choose a runner type
Concerning docker build caching, see https://gitlab.com/gitlab-org/gitlab-ce/issues/17861

## Shell runner with docker
Simplest but least secure runner. Caching just works.
```
salt 'build01' state.apply gitlab.runner.shelldocker
```

## Docker-in-Docker (dind) runner
This one is useful for small images, but caching is ... meh
```
salt 'build01' state.apply gitlab.runner.dind
```


# Notes
I'm not happy with the code-duplication in `docker/` and `shelldocker/`,
but this is a fix for another time. ... maybe :D
