@echo off
TITLE "rclone_rc_daemon"

rclone rcd --rc-web-gui --rc-web-gui-force-update --rc-allow-origin --rc-web-fetch-url --rc-addr [DOMAIN:PORT] --rc-user [USERNAME] --rc-pass [PASSOWRD]