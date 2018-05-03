<<<<<<< HEAD
=======
def empty_branch(command, user)
  "@#{user} forgot to type the branch 😒\nExample: <code>#{command} master</code>"
end

>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
def empty_staging(command, user)
  "@#{user} forgot to type staging name 😒\nExample: <code>#{command}_103</code>"
end

<<<<<<< HEAD
def chat_not_found
  'Jenkins chat not found, please check @mpermperpisang'
=======
def empty_people(user)
  "<code>#{user}</code> ngga ada di squad Bandung 👻"
end

def empty_schedule
  "Yeay banyak cemilan.\nSelamat menggendutkan diri, kawan-kawan\n😈"
end

def empty_retro
  "Retrospective kosong"
end

def empty_deployment(user)
  "Sekarang aku lagi ngga deploy apa-apa, Kak @#{user}"
end

def empty_sprint(user)
  "Sprintnya jangan kosong dong, Kak @#{user}\nFormatnya begini <code>/retro sprint_ke_berapa komentar_buat_retrospective</code>"
end

def empty_sprint_list(user)
  "Sprintnya jangan kosong dong, Kak @#{user}\nFormatnya begini <code>/list_retro sprint_ke_berapa</code>"
end

def empty_poin
  "Belum ada orang yang memberikan poin untuk marketplace"
end

def empty_task(user)
  "Kamu udah ga ada tugas, darling #{user} 😚\nGimana kalau kamu chat ama aku ajah?"
end

def empty_member(squad, user)
  "Stok anggota squad #{squad.upcase} lagi kosong, Kak @#{user}"
end

def empty_snack(command, user)
  "Nice try @#{user} but useless\n"+errorGeneralEmpty(command)
end

def errorGeneralEmpty(command)
  "Formatnya salah, Kak\nCobain deh <code>#{command} @username1 @username2</code>"
end

def errorDev(user)
  "Sorry @#{user}, only BE or FE can request deploy to staging"
end

def errorQA(user)
  "Sorry @#{user}, you're not QA or at least you're not added in QA list yet 😬\nPrivate message @mpermperpisang, please\n\nOr maybe you want to try other features such like /lock, /start, /restart, /stop, /migrate, /reindex or /precompile ☺️"
end

def errorAdmin(user)
  "@#{user}, maap anda belum beruntung :p (kudu ama admin atau PM)"
end

def errorPM(user)
  "@#{user}, maap anda belum beruntung :p (kudu ama PM, APM atau admin)"
end

def errorStaging(user)
  "Bukan staging milik squad BBM, @#{user}"
end

def errorDeploy(user, staging, name)
  "@#{user} did not booking <code>staging#{staging}</code> but trying to deploy into it\nFYI @#{name}"
end

def errorSpam(user)
  "@#{user} terdeteksi sebagai spammer"
end

def errorGeneralDay
  "Day format is invalid, please use only <b>mon</b>, <b>tue</b>, <b>wed</b>, <b>thu</b> or <b>fri</b>\nExample:"
end

def errorAddDay(command)
  errorGeneralDay+" <code>#{command} mon @username</code>"
end

def errorEditDay(command)
  errorGeneralDay+" <code>#{command} mon @username</code>"
end

def errorChangeDay(command)
  errorGeneralDay+" <code>#{command} mon @username</code>"
end

def errorTodo(user)
  "@#{user} please jangan pake tulisan aneh-aneh, Ve pusing nih 😵"
end

def holiday_schedule
  "Libur telah tiba\nHatiku gembira ⛱🏖🏝"
end

def msg_deploy(user, branch)
  "@#{user} is requesting to deploy.\nBranch: <b>#{branch.strip}</b>"
end

def msg_list_request(list)
  "List of deploy requests :\n\n#{list}\n\n@mpermperpisang @amananm513 @rezaldy08"
end

def deployed(user)
  "Already deployed all branch to staging\nOtsukaresamadeshita"
end

def msg_cancel_deploy(branch)
  "Request deploy branch <b>#{branch}</b> has been canceled"
end

def msg_book_staging(user, staging)
  "@#{user} is booking <code>staging#{staging}</code>"
end

def msg_using_staging(user, staging, name)
  "<code>@#{user}</code> is still using <code>staging#{staging}</code>, @#{name}"
end

def msg_done_staging(user, staging)
  "@#{user} has done using <code>staging#{staging}</code>"
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
end

def msg_block_deploy(user)
  "Please book the staging first, @#{user}"
end

<<<<<<< HEAD
def mention_admin
  'Colek Kak @mpermperpisang'
end

def send_off(bot)
  "#{bot} offline, please check @mpermperpisang"
end

def empty_branch(command, user)
  "@#{user} forgot to type the branch 😒\nExample: <code>#{command} master</code>"
end

def new_staging(name, staging)
  "<code>staging#{staging}.vm</code> staging baru yaa, Kak @#{name}?
  Bilang ke Kak @mpermperpisang dulu yaa buat ditambahin ke daftar 😉"
end

def error_deploy(user, staging, name)
  "@#{user} did not booking <code>staging#{staging}</code> but trying to deploy into it\nFYI @#{name}"
end

def msg_queue_deploy(user, staging, branch, name, queue)
  "@#{user} is deploying <code>staging#{staging}</code>
Branch: <b>#{branch.strip}</b>
Requesting by #{name}
Cap queue: #{queue}"
=======
def msg_deploy_staging(user, staging, branch, name)
  "@#{user} is deploying <code>staging#{staging}</code>\nBranch: <b>#{branch.strip}</b>\nRequester: #{name}"
end

def msg_deploy_staging_done(user, staging, name, status)
  "Ayeay @#{user}, deploy <code>staging#{staging}</code> is done with <b>#{status}</b> status\nFYI #{name}"
end

def msg_queue_deploy(user, staging, branch, name, queue)
  "@#{user} is deploying <code>staging#{staging}</code>\nBranch: <b>#{branch.strip}</b>\nRequesting by #{name}\nCap queue: #{queue}"
end

def msg_lock_release(staging)
  "Lock release <code>staging#{staging}</code>"
end

def msg_queue_lock(staging, queue)
  "Lock release <code>staging#{staging}</code>\nCap queue: #{queue}"
end

def msg_lock_staging(user, staging)
  "Ayeay @#{user}, lock:release <code>staging#{staging}</code> is done"
end

def msg_backburner(type, staging)
  "Backburner #{type} <code>staging#{staging}</code>"
end

def msg_queue_backburner(type, staging, queue)
  bb = type.gsub(':', ' ')
  type_bb = bb.gsub('backburner', 'Backburner')
  "#{type_bb} <code>staging#{staging}</code>\nCap queue: #{queue}"
end

def msg_queue_migrate(staging, queue)
  "Database migrate <code>staging#{staging}</code>\nRake queue: #{queue}"
end

def msg_queue_reindex(staging, queue)
  "Database reindex <code>staging#{staging}</code>\nRake queue: #{queue}"
end

def msg_queue_precompile(staging, queue)
  "Asset precompile <code>staging#{staging}</code>\nRake queue: #{queue}"
end

def msg_backburner_staging(user, staging, action)
  "Ayeay @#{user}, backburner of <code>staging#{staging}</code> has #{action}"
end

def msg_rake(type, staging)
  "#{type} <code>staging#{staging}</code>"
end

def msg_rake_staging(user, staging, action)
  "Ayeay @#{user}, database of <code>staging#{staging}</code> has #{action}"
end

def msg_add_people(user, name, day)
  "Cihuy <code>@#{user}</code> nambahin #{name} buat bawa snack di hari #{day}\n\nCatat juga di <a href='https://bukalapak.atlassian.net/wiki/spaces/BS/pages/347046333/Snack+Schedule'>CONFLUENCE</a> yaa"
end

def msg_duplicate_add_people(user, name)
  "@#{user}, kok <code>#{name}</code> didaftarin lagi sih? 😅"
end

def msg_duplicate_task(user, list)
  "@#{user} tasknya udah ada nih, dear\nstatusnya <b>#{list}</b>"
end

def msg_edit_people(user, name, day)
  "Oi oi oi #{name} jadwal snacknya udah diganti sama <code>@#{user}</code> jadi hari #{day} yaa"
end

def msg_change_people(user, name, day)
  "Haeyo #{name}, sekarang jadwalnya jadi hari #{day}\n\nUbah juga di <a href='https://bukalapak.atlassian.net/wiki/spaces/BS/pages/347046333/Snack+Schedule'>CONFLUENCE</a> yaa"
end

def msg_delete_people(user)
  "ByBy #{user}"
end

def msg_done_spam(user, name)
  "<code>#{name}</code> udah bawa 🐍 kok\n@#{user} ngga usah nge-spam deh"
end

def msg_holiday_spam(user, name)
  "<code>#{name}</code> lagi libur bawa 🐍 tau\n@#{user} ngga usah nge-spam deh"
end

def msg_done_people(user)
  "Yeay dapat cemilan dari #{user}.\nSelamat menggendutkan diri, kawan-kawan\n😈"
end

def msg_reminder_schedule(day, user)
  "Jadwal kamu kan hari #{day}, Sayang\n#{user} lupa yaa? 😤"
end

def msg_holiday(user)
  "Libur eceu, @#{user} 😒"
end

def msg_reminder_people(day, name, user)
  "Ayoyo ojo lali. Daftar yang belum bawa hari #{day}\n#{name}\n\n*yang merasa belum diwajibkan untuk membawa snake, abaikan saja pesan ini\nby : <code>@#{user}</code>"
end

def msg_cancel_people(user)
  "#{user} ndak jadi bawa 🐍"
end

def msg_holiday_all
  "Selamat hari libur berjamaah yaa, Kak"
end

def msg_holiday_people(user)
  "<code>#{user}</code> izin libur dulu yaa"
end

def msg_normal_snack
  "Snack sudah kembali sesuai jadwal di <a href='https://bukalapak.atlassian.net/wiki/spaces/BS/pages/347046333/Snack+Schedule'>CONFLUENCE</a> yaa"
end

def msg_add_hi5(squad, name)
  "Berhasil menambahkan #{name} di squad #{(squad.upcase).strip}"
end

def msg_delete_hi5(squad, name)
  "Berhasil menghapus #{name} di squad #{(squad.upcase).strip}"
end

def msg_edit_hi5(squad, name)
  "Berhasil mengubah #{name} di squad #{(squad.upcase).strip}"
end

def msg_invalid_hi5
  "Tapi kalau maksud Kakak buat nambahin anggota ke daftar HI5, formatnya salah, Kak\nSquad Bandung yang ada saat ini: <b>WTB</b>, <b>BBM</b>, <b>ART</b>, <b>CORE</b> (Apps) dan <b>DISCO</b>\nContoh buat nambahin username ke daftar HI5\n\n<code>/hi5 bbm @username1 @username2</code>\n\n🐾 Kalau ada perubahan squad di Bandung tolong kasih tau @mpermperpisang yaa"
end

def msg_format_hi5
  "Formatnya salah, Kak\nCobain deh <code>/hi5 bbm</code> atau <code>/hi5 core</code> atau <code>/hi5 disco</code>"
end

def msg_invalid_squad(squad, user)
  "<code>#{squad.upcase}</code> squad apa tuch, Kak @#{user}?\nAku cuma tau squad <b>WTB</b>, <b>BBM</b>, <b>ART</b>, <b>CORE</b> (Apps) dan <b>DISCO</b>"
end

def msg_todo(user)
  "Aku udah catat tugas kamu yaa, @#{user}"
end

def msg_todo_list(user, list)
  "Halo dear, ini daftar tugas kamu yaa\n@#{user} fighting 😘:\n\n#{list}"
end

def msg_rescue_todo(user)
  "Dear @#{user}, japri aku dulu dong (@#{ENV['BOT_TODO']}) nanti aku kasih tau tugas kamu apa ajah\n☺️"
end

def msg_rescue_retro(user)
  "Kakak @#{user} baru bisa nulis retro kalau japri aku (@#{ENV['BOT_TODO']})"
end

def msg_rescue_list_retro(user)
  "Silahkan japri aku (@#{ENV['BOT_TODO']}) yaa, Kak @#{user}"
end

def msg_rescue_poin(user)
  "Poinnya japri dong (@#{ENV['BOT_TODO']}), Kak @#{user}\nBiar ga saling contek 👀"
end

def msg_rescue_show(command, user)
  "Sekarang perintah <code>#{command}</code> harus di grup, Kak @#{user}\nMohon maaf atas ketidaknyamanannya 😣"
end

def msg_poin(poin, name)
  "Poin <b>#{poin}</b>\nFrom <code>#{name}</code>"
end

def msg_break(poin, name)
  "Kata Kak #{name}, <b>#{poin}</b>"
end

def msg_fibonnaci
  "Poinnya harus angka fibonnaci, Kak"
end

def msg_weather(weather, poem)
  "Hari ini katanya sih cuacanya #{weather} loh#{poem} 🤗"
end

def copy_data(text)
  Clipboard.copy("#{text}")
end

def mention_admin
  "Colek Kak @mpermperpisang"
end

def run_offline(comm)
=begin
  case comm
  when "snack"
    @command = "nohup ruby run/bandung/snack.rb &"
    @grep = "run/bandung/snack.rb"
  when "booking"
    @command = "nohup ruby run/bbm/booking.rb &"
    @grep = "run/bbm/booking.rb"
  when "jenkins"
    @command = "nohup ruby run/bbm/jenkins.rb &"
    @grep = "run/bbm/jenkins.rb"
  when "todo"
    @command = "nohup ruby run/bbm/todo.rb &"
    @grep = "run/bbm/todo.rb"
  end
=end

  mention_admin
  #+" atau ketik <code>#{@command}</code> di <b>staging103</b> folder bot\nTapi pastikan dulu dengan ketik <code>ps aux | grep -i #{@grep}</code> yaa"
end

def bot_offline(bot)
  "#{bot} offline, please check @mpermperpisang"
end

def copy_hi5(user)
  "Copy hi5 success, @#{user}"
end

def list_schedule(day, name, count)
  "Jadwal snack #{day}:\n<code>#{name}</code>\nJumlah: #{count} orang"
end

def msg_welcome_member(user)
  "Selamat datang di squad Bandung, Kak #{user}\nSalam kenal, namaku #{ENV['NAME_REMINDER']}\n🤗"
end

def msg_left_member(user)
  "Sayonara, Kak #{user}\nSemoga semakin sukses dan sehat selalu\nJangan lupa sama squad Bandung yaa 👋🏻"
end

def welcome_text(user)
  "Selamat datang, #{user}\nSilahkan ketik /help untuk tahu informasi lebih lanjut yaa"
end

def msg_done_list(name, task)
  "Hai @#{name}, akhirnya yaa tugas <b>#{task}</b> kelar juga"
end

def msg_save_retro(sprint)
  "Retro untuk sprint #{sprint} sudah disimpan yaa, Kak"
end

def msg_list_retro(sprint, list)
  "Daftar restrospective sprint #{sprint}\n\n#{list}"
end

def msg_invalid_sprint
  "Sprintnya ga valid tuh, Kak\nHarus angka yaa 😵\nContohnya begini <code>/retro 21 retrospective</code>"
end

def accepted_poin
  "Poin diterima. Kakak ga bisa ubah nilai yang udah diberikan yaa 😇"
end

def msg_new_poin
  "Menampilkan poin\nSilahkan cek rame-rame di grup BBM Bot Announcements yaa"
end

def msg_new_poin_member
  "Menampilkan poin\nSilahkan cek rame-rame di grup BBM Bot Announcements yaa\n\nKloter sudah dibuka, tunggu aba-aba dari PM/APM yaa"
end

def msg_send_retro
  "Mengirim retro ke grup BBM Bot Announcements"
end

def choose_squad(user)
  "Pilih squadnya yaa, Kak @#{user}"
end

def new_staging(name, staging)
  "<code>staging#{staging}.vm</code> staging baru yaa, Kak @#{name}? Bilang ke Kak @mpermperpisang dulu yaa buat ditambahin ke daftar 😉"
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
end

def list_deployment(list, user)
  "Sekarang aku lagi nge-deploy daftar ini ke staging, Kak @#{user}\nMohon bersabar yaa 😚\n\n#{list}"
end

<<<<<<< HEAD
def empty_deployment(user)
  "Sekarang aku lagi ngga deploy apa-apa, Kak @#{user}"
=======
def list_poin_market(poin)
  "Poin for marketplace\n======================================\n#{poin}\n\ncolek @ak_fahmi @Maharaniar"
end

def change_comm
  "Halo Kak, commandnya dah ganti loh"
end

def show_command
  "Daripada capek ngetik terus, mending klik /show (untuk menampilkan poin) atau pilih dari keyboard di bawah ini aja (untuk memilih poin), Kak\nHave a nice marketplace ☺️"
end

def next_chance
  "tunggu kloter berikutnya yaa"
end

def not_member_market
  "Kakak belum terdaftar untuk ikut marketplace\nCoba tanya ke Kak @mpermperpisang ajah yaa"
end

def command_not_found(user)
  "Ngetik apaan sih, Kak @#{user}?"
end

def next_poin
  "Menunggu poin selanjutnya"
end

def done_poin(poin)
  "Yang sudah memberikan poin:\n#{poin}\n\nKalau sudah selesai, klik /show yaa, Kak"
end

def list_hi5(squad, count)
  "Hi5 squad <b>#{squad}</b>\nKalo daftar ini ga update, mohon kasih tau <code>@mpermperpisang</code> yaa\nJumlah: #{count} orang"
end

def normalize(staging, date)
  "Date of <code>staging#{staging}</code> become <b>#{date}</b>"
end

def cancel_empty(user, branch)
  "Branch <code>#{branch}</code> tidak ditemukan dalam daftar request deploy\nJadi ga bisa dicancel, Kak @#{user}"
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
end
