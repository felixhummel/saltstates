# Getting Started
```
cat <<EOF > /srv/pillar/gitlab-runner.sls
gitlab-runner:
  CI_SERVER_URL: https://git.example.org/
  REGISTRATION_TOKEN: XXX
EOF
vi /srv/pillar/gitlab-runner.sls

vi /srv/pillar/top.sls  # add 'gitlab-runner'
```

Install and register a docker runner
```
salt 'build01' state.apply gitlab.runner.docker
```
