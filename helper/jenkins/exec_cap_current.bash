#!/bin/bash
source /home/bukalapak/bot/require/ruby_cap.rb
sshpass -p "bukalapak" ssh bukalapak@$ip_staging <<ENDSSH
  cd current
  printf "$staging_branch\nbukalapak\nbukalapak" | bundle exec cap staging $type &> ~/current/log/cap.log
ENDSSH
