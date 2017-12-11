#!/bin/bash
source ./callruby.rb
sshpass -p "yourpassword" ssh username@staging <<ENDSSH
  mysql -u"root" -p"yourpassword" -D"yourdatabase" -e"select day from yourtabel where name='$name'" > bot/callruby.rb
ENDSSH