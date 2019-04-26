#!/bin/bash
source ./require_ruby.rb

echo "$month $time"

sshpass -p "password" ssh user@$ip_staging <<ENDSSH
  echo "$date $time"
  echo "password" | sudo -S date --set "$date $time"
ENDSSH
