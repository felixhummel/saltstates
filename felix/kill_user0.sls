# user0 is my convention for first user with auto-generated uid
# WARNING: Make sure you have sudo rights or another privileged user before
#          running this!
include:
  - felix

remove_default_user:
  user.absent:
    - name: user0
    - require:
      - user: felix
  file.absent:
    - name: /home/user0


