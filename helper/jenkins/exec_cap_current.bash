#!/bin/bash
source /home/bukalapak/bandung-telegram-bot/require/ruby_cap.rb
sshpass -p "password" ssh user@$ip_staging <<ENDSSH
  cd current
  printf "$staging_branch\npassword\npassword" | bundle exec cap staging $type &> ~/current/log/cap.log
ENDSSH
