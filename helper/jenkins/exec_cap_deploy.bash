#!/bin/bash
source /home/bukalapak/bandung-telegram-bot/require/ruby_cap.rb
sshpass -p "password" ssh user@$ip_staging <<ENDSSH
  cd deploy
  printf "$staging_branch\npassword\npassword" | bundle exec cap staging $type &> ~/deploy/log/cap.log
ENDSSH
