#!/bin/bash
source ./callruby.rb
sshpass -p "yourpassword" ssh username@staging <<ENDSSH
  mysql -u"root" -p"yourpassword"
  use yourdatabase;
  update yourtabel set day='$day' where name='$name';
ENDSSH