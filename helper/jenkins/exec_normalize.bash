#!/bin/bash
source ./require_ruby.rb

echo "$month $time"

sshpass -p "bukalapak" ssh bukalapak@$ip_staging <<ENDSSH
  echo "$date $time"
  echo "bukalapak" | sudo -S date --set "$date $time"
ENDSSH
