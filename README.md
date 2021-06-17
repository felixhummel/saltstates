# Felix' Salt States

The following is for a [masterless][] setup.

[masterless]: https://docs.saltstack.com/en/latest/topics/tutorials/quickstart.html

Install Salt via https://bootstrap.saltstack.com
```
curl https://raw.githubusercontent.com/felixhummel/saltstates/master/bin/masterless.sh | sudo -i bash
```
See [bin/masterless.sh](bin/masterless.sh) for details.


# Default (Debian 9)
```
sudo -i

git init /srv/salt
git init /srv/pillar

cd /srv/salt
git submodule add https://github.com/felixhummel/saltstates felix/

cp -r felix/examples/salt /srv/salt
cp -r felix/examples/pillar /srv/pillar

cat << 'EOF' > /etc/salt/minion
# https://docs.saltstack.com/en/latest/ref/output/all/salt.output.highstate.html
state_verbose: False
state_output: changes

file_client: local
file_roots:
  base:
    - /srv/salt
  felix:
    - /srv/salt/felix

top_file_merging_strategy: same
EOF

salt-call grains.get id
salt-call pillar.get users
salt-call state.apply test=true
```
