# Postfix

This supplies multiple modes of operation:

- simple Postfix MTA that can send mails
- with SPF
- with DKIM

See `pillar.example` as a reference.


# Simple
```
cp pillar.example /srv/pillar/postfix.sls
vi /srv/pillar/postfix.sls
vi /srv/pillar/top.sls
salt-call state.apply postfix
```

Test
```
echo 'test' | mail -s 'test' test@felixhummel.de
```

Make sure to check your spam!


## Mapping Unix-Users to custom addresses
See `man 5 generic` and the `generic_map` key in `pillar.example`.

Test
```
sudo -iu monit bash -c "echo 'test' | mail -s 'test monit' test@felixhummel.de"
```


# SPF
Simply add your IP to your DNS SPF record, e.g.
```
v=spf1 mx a include:example.org ip4:1.2.3.4/32 ~all
```
This uses version 1 allowing

- servers set in the MX and A records
- the policy of `example.org`
- the IP address `1.2.3.4`

and then SOFTFAILs for anything else.

When you are happy with the results, change `~all` to `-all`, so it FAILs.

[Wikipedia](https://en.wikipedia.org/wiki/Sender_Policy_Framework) has more on this.

Test:
```
echo 'test' | mail -s 'test SPF' test@felixhummel.de
```

You should see `spf=pass` in `Authentication-Results`.

