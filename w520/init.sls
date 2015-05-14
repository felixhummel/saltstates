# http://askubuntu.com/questions/76081/brightness-not-working-after-installing-nvidia-driver
# To generate a reference xorg.conf:
# - shut down X and kdm/lightdm
# - run ``X -configure``
/usr/share/X11/xorg.conf.d/10-nvidia-brightness.conf:
  file.managed:
    - source: salt://w520/10-nvidia-brightness.conf

