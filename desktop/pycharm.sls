# https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
fs.inotify.max_user_watches:
  sysctl.present:
    - value: 524288
    - config: /etc/sysctl.d/60-inotify-max_user_watches.conf
