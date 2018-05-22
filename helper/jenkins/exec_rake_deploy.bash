#!/bin/bash
source /home/bukalapak/bandung-telegram-bot/require/ruby_rake.rb
sshpass -p "bukalapak" ssh bukalapak@$ip_staging <<ENDSSH
  cd current
  if [ "$type" == "elasticsearch:reindex_index" ]
    then
      printf "LOG searcheror:create_indices\n" &> ~/deploy/log/rake.log
      RAILS_ENV=staging bundle exec rake searcheror:create_indices &>> ~/deploy/log/rake.log
      printf "\n\nLOG searcheror:reindex\n" &>> ~/deploy/log/rake.log
      RAILS_ENV=staging bundle exec rake searcheror:reindex &>> ~/deploy/log/rake.log
      printf "\n\nLOG elasticsearch:reset_index\n" &>> ~/deploy/log/rake.log
      RAILS_ENV=staging bundle exec rake elasticsearch:reset_index &>> ~/deploy/log/rake.log
      printf "\n\nLOG elasticsearch:reindex_index\n" &>> ~/deploy/log/rake.log
      RAILS_ENV=staging bundle exec rake $type &>> ~/deploy/log/rake.log
  else
    RAILS_ENV=staging bundle exec rake $type &> ~/deploy/log/rake.log
  fi
ENDSSH
