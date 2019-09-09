{#
Get rid of "ttyname failed: Inappropriate ioctl for device" messages; especially
"salt-minion[413]: mesg: ttyname failed: Inappropriate ioctl for device"

Thanks to https://superuser.com/a/1277604/182585
#}

/root/.profile:
  file.managed:
    - source: salt://warts/bash/root_profile
    # only manage this if it already exists
    - create: False

