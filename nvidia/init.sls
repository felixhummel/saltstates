# fix tearing
# http://askubuntu.com/questions/456355/have-tearing-no-vsync-in-movies-nvidia-proprietary-driver
/etc/profile.d/tearing.sh:
  file.managed:
    - source: salt://nvidia/tearing.sh
    - user: root
    - group: root
    - mode: 700

