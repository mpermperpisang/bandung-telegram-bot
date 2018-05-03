require './message/message_text.rb'
require './database/crud.rb'

module Bot
  class DBConnect
    @@db = Connection.new
    @@msg = MessageText.new

    @@msg.connection

    def initialize
      @@db.db_connect(@@msg.host, @@msg.username, @@msg.password)
    end

    def check_deploy(branch)
      @@db.check_deploy(branch)
    end

    def list_request
      @@db.list_request
    end

    def deploy(branch, user)
      @@db.deploy(branch, user)
    end

    def update_deploy(branch, user)
      @@db.update_deploy(branch, user)
    end

    def status_staging
      @@db.status_staging
    end

    def cancel_deploy(branch)
      @@db.cancel_deploy(branch)
    end

    def status_booking(staging)
      @@db.status_booking(staging)
    end

    def book_staging(user, id, staging)
      @@db.book_staging(user, id, staging)
    end

    def done_booking(staging)
      @@db.done_booking(staging)
    end

    def done_staging(staging)
      @@db.done_staging(staging)
    end

    def check_booked(staging)
      @@db.check_booked(staging)
    end

    def list_requester(branch)
      @@db.list_requester(branch)
    end

    def staging_deploy(staging, branch)
      @@db.staging_deploy(staging, branch)
    end

    def deployed(branch)
      @@db.deployed(branch)
    end

    def check_spam(user, command)
      @@db.check_spam(user, command)
    end

    def save_spam(user, command)
      @@db.save_spam(user, command)
    end

    def check_people(user)
      @@db.check_people(user)
    end

    def add_people(day, user)
      @@db.add_people(day, user)
    end

    def edit_people(day, user)
      @@db.edit_people(day, user)
    end

    def change_people(day, user)
      @@db.change_people(day, user)
    end

    def delete_people(user)
      @@db.delete_people(user)
    end

    def invalid_day(day)
      @@db.invalid_day(day)
    end

    def check_done(user)
      @@db.check_done(user)
    end

    def done_people(day, name)
      @@db.done_people(day, name)
    end

    def check_day(user)
      @@db.check_day(user)
    end

    def remind_people(day)
      @@db.remind_people(day)
    end

    def cancel_people(user)
      @@db.cancel_people(user)
    end

    def holiday_all(day)
      @@db.holiday_all(day)
    end

    def holiday_people(user)
      @@db.holiday(user)
    end

    def bandung_hi5
      @@db.bandung_hi5
    end

    def bandung_hi5_squad(squad)
      @@db.bandung_hi5_squad(squad)
    end

    def normal_snack
      @@db.normal_snack
    end

    def add_hi5(squad, name)
      @@db.add_hi5(squad, name)
    end

    def edit_hi5(squad, name)
      @@db.edit_hi5(squad, name)
    end

    def check_list(name)
      @@db.check_list(name)
    end

    def todo_list(id, name)
      @@db.todo_list(id, name)
    end

    def check_hi5(squad, name)
      @@db.check_hi5(squad, name)
    end

    def check_hi5_bandung(name)
      @@db.check_hi5_bandung(name)
    end

    def delete_hi5(squad, name)
      @@db.delete_hi5(squad, name)
    end

    def delete_member_hi5(name)
      @@db.delete_member_hi5(name)
    end

    def edit_hi5(squad, name)
      @@db.edit_hi5(squad, name)
    end

    def squad_hi5(squad)
      @@db.squad_hi5(squad)
    end

    def deploy_branch(branch)
      @@db.deploy_branch(branch)
    end

    def snack_schedule(day)
      @@db.snack_schedule(day)
    end

    def people_holiday(day)
      @@db.people_holiday(day)
    end

    def recall_list(name)
      @@db.recall_list(name)
    end

    def done_task(name)
      @@db.done_task(name)
    end

    def save_retro(sprint, retro, name)
      @@db.save_retro(sprint, retro, name)
    end

    def retrospective(sprint)
      @@db.list_retrospective(sprint)
    end

    def update_retro(sprint)
      @@db.update_retro(sprint)
    end

    def check_poin_closed
      @@db.check_poin_closed
    end

    def check_poin_open(user)
      @@db.check_poin_open(user)
    end

    def update_market_open
      @@db.update_market_open
    end

    def update_market_closed(poin, name)
      @@db.update_market_closed(poin, name)
    end

    def open_retro(sprint)
      @@db.open_retro(sprint)
    end

    def list_queue(name, chat, ip, staging, branch, type)
      @@db.list_queue(name, chat, ip, staging, branch, type)
    end

    def number_queue_cap
      @@db.number_queue_cap
    end

    def number_queue_lock
      @@db.number_queue_lock
    end

    def number_queue_backburner
      @@db.number_queue_backburner
    end

    def number_queue_rake
      @@db.number_queue_rake
    end

    def number_queue_reindex
      @@db.number_queue_reindex
    end

    def number_queue_precompile
      @@db.number_queue_precompile
    end

    def insert_queue(name, chat, ip, staging, branch, type)
      @@db.insert_queue(name, chat, ip, staging, branch, type)
    end

    def check_branch_queue(branch)
      @@db.check_branch_queue(branch)
    end

    def list_poin
      @@db.list_poin
    end

    def list_deployment
      @@db.list_deployment
    end

    def message_chat_id
      @@db.message_chat_id
    end

    def id_get_poin(user, id)
      @@db.id_get_poin(user, id)
    end

    def message_from_id
      @@db.message_from_id
    end

    def check_member_market(user)
      @@db.check_member_market(user)
    end

    def update_message_id(id)
      @@db.update_message_id(id)
    end

    def update_chat_id(id)
      @@db.update_chat_id(id)
    end

    def show_message_id
      @@db.show_message_id
    end

    def list_accepted_poin
      @@db.list_accepted_poin
    end

    def chat_market
      @@db.chat_market
    end

    def save_booking(name, room, date, from, to, fromm, tom)
      @@db.save_booking(name, room, date, from, to, fromm, tom)
    end

    def bandung_email
      @@db.bandung_email
    end

    def reset_reminder(day)
      @@db.reset_reminder(day)
    end

    def check_deploy_req(branch)
      @@db.check_deploy_req(branch)
    end

    def deploy_duration(duration, branch)
      @@db.deploy_duration(duration, branch)
    end
  end
end
