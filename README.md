# telegram-bot-snack

every week in my office, one person have a duty to bring a snack for the squad, so here is I create a bot reminder to remind the member to bring their snack for their squad

there is cron_reminder.rb that have running every weekdays by crontab -e in linux and that's automatically mention member in duty for bringing snack on that day as their scheduled
but then there is reminder.rb that received listener from bot's user so it can add, edit, delete, done or remind manually user
