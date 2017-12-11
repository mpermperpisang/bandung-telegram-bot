#!/bin/bash
source ./callruby.rb
sshpass -p "yourpassword" ssh username@staging <<ENDSSH
  mysql -u"root" -p"yourpassword"
  use yourdatabase;
  update yourtabel set status='sudah' where name='$name' and day='$day' and status='belum';
ENDSSH