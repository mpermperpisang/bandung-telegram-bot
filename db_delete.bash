#!/bin/bash
source ./callruby.rb
sshpass -p "yourpassword" ssh username@staging <<ENDSSH
  mysql -u"root" -p"yourpassword"
  use yourdatabase;
  delete from yourtabel where name='$name';
ENDSSH