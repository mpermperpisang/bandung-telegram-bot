#!/bin/bash
source ./callruby.rb
sshpass -p "yourpassword" ssh username@staging <<ENDSSH
  mysql -u"root" -p"yourpassword" -D"yourdatabase" -e"SELECT name FROM yourtabel where day='$day' and status='belum'; update yourtabel set status='belum' where day<>'$day'" > bot/callruby.rb
ENDSSH