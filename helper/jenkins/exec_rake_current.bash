#!/bin/bash
source /home/bukalapak/bandung-telegram-bot/require/ruby_rake.rb
sshpass -p "bukalapak" ssh bukalapak@$ip_staging <<ENDSSH
  cd current
  if [ "$type" == "elasticsearch:reindex_index" ]
    then
      printf "LOG searcheror:create_indices\n" &> ~/current/log/rake.log
      RAILS_ENV=staging bundle exec rake searcheror:create_indices &>> ~/current/log/rake.log
      printf "\n\nLOG searcheror:reindex\n" &>> ~/current/log/rake.log
      RAILS_ENV=staging bundle exec rake searcheror:reindex &>> ~/current/log/rake.log
      printf "\n\nLOG elasticsearch:reset_index\n" &>> ~/current/log/rake.log
      RAILS_ENV=staging bundle exec rake elasticsearch:reset_index &>> ~/current/log/rake.log
      printf "\n\nLOG elasticsearch:reindex_index\n" &>> ~/current/log/rake.log
      RAILS_ENV=staging bundle exec rake $type &>> ~/current/log/rake.log
  else
    RAILS_ENV=staging bundle exec rake $type &> ~/current/log/rake.log
  fi
ENDSSH
