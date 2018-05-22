#!/bin/bash
source /home/bukalapak/bandung-telegram-bot/require/ruby_cap.rb
sshpass -p "bukalapak" ssh bukalapak@$ip_staging <<ENDSSH
  cd deploy
  printf "$staging_branch\nbukalapak\nbukalapak" | bundle exec cap staging $type &> ~/deploy/log/cap.log
ENDSSH
