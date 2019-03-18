def empty_staging(com, user)
  @comm = com
  @user = user
  @comm.start_with?('/status_staging') ? empty_status : empty_general
end

def general_empty_stg
  "@#{@user} forgot to type staging name 😒"
end

def empty_general
  general_empty_stg + "\nExample: <code>#{@comm} 103</code>"
end

def empty_status
  general_empty_stg + "\nExample: <code>#{@comm} 21 51 103 or #{@comm} DANA</code>"
end

def stg_not_exist(stg)
  general_stg = 'dilihat statusnya' if @txt.start_with?('/status')
  general_stg = 'di-done-kan' if @txt.start_with?('/done')
  "Belum pernah ada yang booking <code>staging#{stg}.vm</code>, jadi ga bisa " + general_stg + ", Kak
\nLangsung ketik ajah <code>/booking #{stg}</code>"
end

def chat_not_found
  'Jenkins chat not found, please check @mpermperpisang'
end

def msg_block_deploy(user)
  "Please book the staging first, @#{user}"
end

def mention_admin(bot)
  @type = case bot
          when 'snack'
            "<a href='https://bit.ly/2IasjuJ'>tutorial Heavy Snack Rotation Bot</a>"
          when 'booking'
            "<a href='https://bit.ly/2rE8Nvt'>tutorial Booking Staging Bot</a>"
          when 'jenkins'
            "<a href='https://bit.ly/2wyenFj'>tutorial QA Jenkins Bot</a>"
          when 'todo'
            "<a href='https://bit.ly/2Iy1Czo'>tutorial Squad Marketplace Bot</a>"
          end
  "Colek Kak @mpermperpisang atau baca #{@type}"
end

def send_off(bot)
  "#{bot} offline, please check @mpermperpisang"
end

def empty_branch(comm, user)
  "@#{user} forgot to type the branch 😒\nExample: <code>#{comm} master</code>"
end

def msg_format_add_stg(comm, user)
	"Format is invalid, @#{user} 😒\nExample: <code>#{comm} DANA 21 51 103</code>"
end

def new_staging(name, staging)
  "Cihuy ada staging baru. staging#{staging}.vm sudah ditambahkan ke daftar yaa, Kak @#{name}"
end

def error_deploy(user, staging, name)
  "@#{user} did not booking <code>staging#{staging}</code> but trying to deploy into it\nFYI @#{name}"
end

def error_dev(user)
  "Sorry @#{user}, only BE or FE can request deploy to staging"
end

def error_admin(user)
  "@#{user}, maap anda belum beruntung :p (kudu ama admin/PM/APM/QAM/EM)"
end

def error_qa(user)
  "Sorry @#{user}, you're not QA or at least you're not added in QA list yet 😬
Private message @mpermperpisang, please
Or maybe you want to try other features such like /lock, /start, /restart, /stop, /migrate, /reindex or /precompile ☺️"
end

def error_pm(user)
  "@#{user}, maap anda belum beruntung :p (kudu ama PM, APM atau admin)"
end

def msg_queue_deploy(user, staging, branch, name, queue)
  "@#{user} is deploying <code>staging#{staging}</code>
Branch: <b>#{branch.strip}</b>
Requesting by #{name}
Cap queue: #{queue}"
end

def list_deployment(list, user)
  "Sekarang aku lagi nge-deploy daftar ini ke staging, Kak @#{user}\nMohon bersabar yaa 😚\n\n#{list}"
end

def empty_deployment(user)
  "Antriannya kosong, Kak @#{user}\nGo go go"
end

def blocked_bot(user)
  "#{user} ngeblock botnya, please check @mpermperpisang"
end

def welcome_text(user)
  "Selamat datang, #{user}\nSilahkan klik /help untuk tahu informasi lebih lanjut yaa"
end

def msg_queue_cap(type, stg, queue)
  bb = %w[start restart stop]

  cap = "Lock release <code>staging#{stg}</code>" if type == 'lock'
  cap = "Backburner #{type} <code>staging#{stg}</code>" if bb.include?(type)
  cap + "\nCap queue: #{queue}"
end

def msg_queue_rake(type, stg, queue)
  rake = "Database migrate <code>staging#{stg}</code>" if type == 'migrate'
  rake = "Database reindex <code>staging#{stg}</code>" if type == 'reindex'
  rake = "Asset precompile <code>staging#{stg}</code>" if type == 'precompile'
  rake + "\nRake queue: #{queue}"
end

def normalize(stg, date)
  "Date of <code>staging#{stg}</code> become <b>#{date}</b>"
end

def msg_book_staging(user, stg)
  "@#{user} is booking <code>staging#{stg}</code>"
end

def msg_still_book(stg, user)
  "You are still book <code>staging#{stg}</code>, @#{user}"
end

def msg_using_staging(user, stg, name)
  "<code>@#{user}</code> is still using <code>staging#{stg}</code>, @#{name}"
end

def msg_done_staging(user, stg)
  "@#{user} has done using <code>staging#{stg}</code>"
end

def msg_deploy(user, branch)
  "@#{user} is requesting to deploy.\nBranch: <b>#{branch.strip}</b>"
end

def deployed
  "Already deployed all branch to staging\nOtsukaresamadeshita"
end

def msg_list_request(list)
  "List of deploy requests\n\n#{list}\n\n@rezaldy08 @ihsanhsn @denishendriansah "
end

def list_request_access
  'Branch is already in list. Click /list_request, please'
end

def cancel_empty(user, branch)
  "Branch <code>#{branch.strip}</code> tidak ditemukan dalam daftar request deploy
Jadi ga bisa dicancel, Kak @#{user}"
end

def msg_cancel_deploy(branch)
  "Request deploy branch <b>#{branch.strip}</b> has been cancelled"
end

def default_poin
  '0 adalah angka default, Kak'
end

def accepted_poin
  'Poin diterima. Kakak ga bisa ubah nilai yang udah diberikan yaa 😇'
end

def next_chance
  'tunggu kloter berikutnya yaa'
end

def next_poin
  'Menunggu poin selanjutnya'
end

def choose_poin
  'Pilih poin'
end

def block_poin
  'Pemberian poin hanya bisa lewat inline keyboard saja, Kak
Silahkan pilih poin di bawah ini atau klik /keyboard'
end

def not_member_market
  "Kakak belum terdaftar untuk ikut marketplace\nCoba minta ke Scrum Master-nya untuk /add_marketplace yaa"
end

def empty_edit(error)
  "There is no message to edit, please check @mpermperpisang\n#{error}"
end

def list_poin_market(poin, count)
  "Poin for marketplace\n===============\n#{poin}\n
Jumlah perolehan per poin : #{count}"
end

def empty_poin
  'Belum ada orang yang memberikan poin untuk marketplace'
end

def msg_new_poin_member(group)
  "Menampilkan poin\nSilahkan cek rame-rame di grup <b>#{group}</b> yaa\n
Kloter sudah dibuka, tunggu aba-aba dari Scrum Master yaa"
end

def msg_new_poin(group)
  "PERSIAPAN MARKETPLACE\nSilahkan cek rame-rame di grup <b>#{group}</b> yaa"
end

def done_poin(count, poin)
  "Yang sudah memberikan poin <b>#{count}</b> orang\n#{poin}\n\nKalau sudah selesai, klik /show yaa, Kak"
end

def show_command
  "Klik /keyboard (untuk menampilkan keyboard dan memilih poin)
Kalau butuh bantuan, klik /help yaa
Have a nice marketplace ☺️"
end

def msg_duplicate_add_people(user, name)
  "@#{user}, kok <code>#{name}</code> didaftarin lagi sih? 😅"
end

def error_general_day
  "Format is invalid, please use only <b>mon</b>, <b>tue</b>, <b>wed</b>, <b>thu</b> or <b>fri</b>\nExample:"
end

def error_day(com)
  error_general_day + " <code>#{com} mon @username tue @username wed @username thu @username fri @username</code>"
end

def msg_weather(weather, poem)
  "Hari ini katanya sih cuacanya #{weather} loh#{poem} 🤗"
end

def msg_add_people(user, name)
    "Cihuy <code>@#{user}</code> nambahin jadwal
- #{name}
\nCatat juga di <a href='https://bit.ly/2FBKhA4'>CONFLUENCE</a> yaa
Dan baca juga aturan per-snack-an di link tersebut 🙏🏻"
end

def msg_edit_people(user, name)
  "Oi oi oi
- #{name}
\nBy <code>@#{user}</code>"
end

def error_spam(user)
  "@#{user} terdeteksi sebagai spammer"
end

def empty_people(user)
  "<code>#{user}</code> ngga ada di squad Bandung 👻"
end

def error_general_empty(com)
  "Formatnya salah, Kak\nCobain deh <code>#{com} @username1 @username2</code>"
end

def empty_snack(com, user)
  "Nice try @#{user} but useless\n" + error_general_empty(com)
end

def empty_vehicle(user)
  "Ni hao, Kak @#{user}
Mau ngecek pemilik kendaraan yaa? Formatnya <pre>/plat A 123 BC D 456 EF G 789 HI</pre>"
end

def add_empty_vehicle(user)
  "Ni hao, Kak @#{user}
Mau nambahin/ngehapus data pemilik kendaraan yaa? Formatnya
<code>/plat @username1 mobil/motor A 123 BC
@username2 mobil/motor D 456 EF
@username3 mobil/motor G 789 HI</code>"
end

def msg_delete_people(user)
  "ByBy #{user}
\nColek Kak @mpermperpisang, tolong hapus data Kak <b>#{user}</b> di tiny.cc/bukasnack yaa 😙"
end

def msg_SNACK_schedule(day, user)
  "Jadwal kamu kan hari #{day}, Sayang\n#{user} lupa yaa? 😤"
end

def msg_done_spam(user, name)
  "<code>#{name}</code> udah bawa 🐍 kok\n@#{user} ngga usah nge-spam deh"
end

def msg_holiday_spam(user, name)
  "<code>#{name}</code> lagi libur bawa 🐍 tau\n@#{user} ngga usah nge-spam deh"
end

def msg_done_people(user)
  "Yeay dapat cemilan dari Kak #{user}.\nSelamat menggendutkan diri, kawan-kawan\n😈"
end

def see_schedule
  'Lihat jadwal snack'
end

def msg_holiday_all
  'Selamat hari libur berjamaah yaa, Kak'
end

def msg_SNACK_people(day, name, user)
  "Ayoyo ojo lali. Daftar yang belum bawa hari #{day}
#{name}

*minimum snack/orang Rp. 20000 yaa, Kak 😘\nBy <code>@#{user}</code>"
end

def msg_invalid_squad(squad, user)
  @msg = MessageText.new
  @msg.bot_squad

  @list = @msg.squad.to_s.gsub('", "', ", ").delete('["').delete('"]')

  "<code>#{squad.upcase.strip}</code> squad apa tuch, Kak @#{user}?
Aku cuma tau squad <b>#{@list.upcase}</b>"
end

def holiday_schedule
  "Libur telah tiba\nHatiku gembira ⛱🏖🏝"
end

def empty_schedule
  "Yeay banyak cemilan.\nSelamat menggendutkan diri, kawan-kawan\n😈"
end

def msg_cancel_people(user)
  "#{user} ndak jadi bawa 🐍"
end

def msg_holiday_people(user)
  "<code>#{user}</code> izin libur dulu yaa"
end

def msg_normal_snack
  "Snack sudah kembali sesuai dengan jadwal di <a href='https://bit.ly/2FBKhA4'>CONFLUENCE</a> yaa"
end

def msg_change_people(user, name)
  "Haeyo 
- #{name}
\nSelamat tinggal pada jadwal lama 👋🏻👋🏻👋🏻
\nKak @#{user} ojo lali ubah juga di <a href='https://bit.ly/2FBKhA4'>CONFLUENCE</a> yaa"
end

def private_message(user)
  "Tolong japri aku dulu yaa, Kak @#{user} buat tau list Hi5nya"
end

def by_user(user)
  "\n\nBy: <code>@#{user}</code>"
end

def choosing_squad(user)
  "Pilih squadnya yaa, Kak @#{user}"
end

def msg_invalid_hi5
  @msg = MessageText.new
  @msg.bot_squad

  @list = @msg.squad.to_s.gsub('", "', ", ").delete('["').delete('"]')

  "Tapi kalau maksud Kakak buat nambahin anggota ke daftar HI5, formatnya salah, Kak
Squad Bandung yang ada saat ini: <b>#{@list.upcase}</b>
Contoh buat nambahin username ke daftar HI5\n\n<code>/hi5 dana @username1 @username2</code>

Kakak juga bisa japri aku lalu ketik <code>/hi5 bandung</code>, kalau ndak mau mention se-Bukalapak Bandung di grup

🐾 Kalau ada perubahan squad di Bandung tolong kasih tau @mpermperpisang yaa"
end

def list_hi5(squad, count)
  "Hi5 squad <b>#{squad.upcase}</b>\n\nJumlah: #{count} orang"
end

def empty_member(squad, user)
  "Stok anggota squad <b>#{squad.upcase}</b> lagi kosong, Kak @#{user}"
end

def msg_delete_hi5(squad, name)
  "Berhasil menghapus #{name} di squad <b>#{squad.upcase.strip}</b>"
end

def msg_add_hi5(squad, name)
  "Berhasil menambahkan #{name} di squad <b>#{squad.upcase.strip}</b>"
end

def msg_edit_hi5(squad, name)
  "Berhasil mengubah #{name} di squad #{squad.upcase.strip}"
end

def list_schedule(day, name, count)
  "Jadwal snack #{day}:\n<code>#{name}</code>\n\nJumlah: #{count} orang"
end

def telegram_error
  'Telegram stuff, dont worry'
end

def msg_welcome_member(user, group)
  "Selamat datang di squad Bandung, Kak #{user}\nSalam kenal, namaku <b>#{ENV['NAME_SNACK']}</b>\n🤗\n
<b>CEK JAPRIANKU YAA</b> 😁 (Kakak harus japri @#{ENV['BOT_SNACK']} duluan dan klik Start yaa)

Ada info penting terkait Bukalapak Bandung di message yang ku kirim ke Kakak soalnya
Hatur tengkyu, Kak 🙏🏻"
end

def msg_left_member(user)
  "Sayonara, Kak <b>#{user}</b>\nSemoga semakin sukses dan sehat selalu\nJangan lupa sama squad Bandung yaa 👋🏻\n
Colek Kak @lieskadia @sarassar, tolong hapus data Kak <b>#{user}</b> di tiny.cc/bukabandung yaa 😙"
end

def forbid_vehicle(user, name)
  "Woy #{name} 😘, kendaraannya tolong dipindah yaa karena menghalangi kendaraan lain\nBy <code>@#{user}</code>"
end

def empty_owner(user, plat)
  "Halo Kakak-kakak di Bukalapak Bandung, ada yang merasa memiliki kendaraan dengan plat nomor <b>#{plat.upcase}</b>?\n
Tolong pisan yaa dipindahkan 🙏🏻\n\n
Dan mohon update plat nomor kendaraannya masing-masing dengan cara japri aku dan ketik <code>/plat</code>

By <code>@#{user}</code>"
end

def same_vehicle(user)
  "Sama plat nomor kendaraan sendiri lupa, Kak @#{user}? 🤔"
end

def update_bukabandung
  "<b>YUK YUK UPDATE DATA KALIAN DI</b> tiny.cc/bukabandung 😎"
end

def adding_vehicle(vehicle)
  "Berhasil menambahkan daftar kendaraan sebagai berikut:\n- #{vehicle}"
end

def deleting_vehicle(vehicle)
  "Berhasil menghapus daftar kendaraan sebagai berikut:\n- #{vehicle}"
end

def msg_add_admin(name)
  "Berhasil menambahkan nama berikut sebagai admin snack:\n- #{name}"
end

def msg_dupe_admin(name)
  "Duplikasi admin:\n- #{name}"
end

def msg_list_admin(user, name)
  "Halo, Kak @#{user}. Kakak bisa minta bantuan tentang snack ke admin/PM/APM/EM/QAM di bawah ini yaa:
<code>- #{name}</code>"
end

def msg_add_squad(squad)
  "Berhasil menambahkan squad:\n- #{squad.upcase}"
end

def msg_dupe_squad(squad)
  "Duplikasi squad:\n- #{squad.upcase}"
end

def onboarding_member(name)
  "Kak #{name}, yuk perkenalan dulu. Tolong tuliskan biodata dengan format seperti ini :

🐾 Nama panggilan : 
🐾 Job title : 
🐾 Squad : 
🐾 Pekerjaan atau Pendidikan terakhir : 
🐾 Status : 
🐾 Hobi : 
🐾 Motto : "
end

def msg_onboarding(user, name)
  "Kak @#{user}, mohon isi <b>#{name}</b> dengan benar yaa (tidak boleh ada karakter selain huruf dan angka). Formatnya seperti ini :

🐾 Nama panggilan : 
🐾 Job title : 
🐾 Squad : 
🐾 Pekerjaan atau Pendidikan terakhir : 
🐾 Status : 
🐾 Hobi : 
🐾 Motto : 

*chat ini tidak akan hilang kalau belum kirim format biodata seperti di atas 😈
kalau ada kesulitan harap menghubungi Kak @mpermperpisang yaa #semangat"
end

def msg_check_private_msg(user)
  "Kak @#{user}, please japri @#{ENV['BOT_SNACK']} dulu yaa.. Nuhun"
end

def msg_welcome_new_member(name, username)
  "Halo Kakak-kakak di squad Bandung, mohon bimbing Kak @#{username} (<b>#{name}</b>) yaa 🙏🏻"
end

def input_buka_bandung
  "Mohon isi (kasih <b>COMMENT</b>) biodata Kakak di tiny.cc/bukabandung juga yaa
Kemudian dapatkan info terbaru dari Bukalapak Bandung dengan subscribe official channel https://t.me/joinchat/AAAAAFScH6zPovO-LR_9nQ"
end

def all_group_list
  "Mau gabung sama grup yang ada di Bukalapak Bandung, Kak?\n
🐾 https://t.me/joinchat/AJmnGxEJVPlDllU198GfIg Grup Kuliner
🐾 https://t.me/joinchat/C3VkcA74oY2MUAL9_uVjVw Grup Badminton
🐾 https://t.me/joinchat/HgqJSBGPu9Rl-OpceBHwUw Grup Action figure
🐾 https://t.me/joinchat/EH0nV0kmrExNs7dmMD4fAA Grup Patungan kado
🐾 Grup Futsal. Silahkan menghubungi Kak @ivantedja"
end

def be_oncall(user, name)
  "Summoning #{name}
Ayo Kak semangat yaa dalam bertugas 😙🍕🍕🍕"
end

def empty_oncall(user)
  "On call hari ini belum ditentukan, Kak @#{user}
Bisa tanya ke PM atau APM buat jadwalnya yaa (http://tiny.cc/danaoncall)
colek @ak_fahmi @Maharaniar @Oes_Rustandi"
end

def no_oncall(user)
  "Libur dulu atuh, Kak @#{user}
Kasihan Kakak BEnya dicolek-colek pas weekend"
end

def msg_dupe_stg_squad(stg, squad)
  "Staging #{stg} sudah pernah terdaftar sebagai staging squad #{squad.upcase}"
end

def msg_add_stg_squad(stg, squad, user)
  "Staging #{stg} sudah ditambahkan ke daftar squad #{squad.upcase} yaa, Kak @#{user}"
end

def msg_update_stg_squad(stg, squad, user)
  "Staging #{stg} sudah diubah menjadi staging milik squad #{squad.upcase} yaa, Kak @#{user}"
end

def empty_staging_squad(squad, user)
  "Belum ada daftar staging di squad #{squad.upcase}
Tambahin yuk Kak @#{user} caranya ketik ajah <code>/add_staging</code>"
end

def error_empty_member(comm)
	"Formatnya salah, Kak\n<code>#{comm} @username1 @username2 @username3</code>"
end

def msg_add_marketplace(user, group)
	"#{user} sudah didaftarkan ke marketplace #{group}"
end

def msg_delete_marketplace(user, group)
	"#{user} sudah dihapus dari marketplace #{group}"
end

def msg_dupe_marketplace(user, group)
	"#{user} sudah pernah terdaftar sebagai anggota marketplace #{group}"
end

def msg_empty_marketplace(user, group)
	"Di dalam marketplace #{group} tidak ada anggota dengan nama #{user}"
end

def choose_market(list)
	"Kakak terdaftar dalam multiple squad. Silahkan pilih mau mengikuti marketplace yang mana, dengan cara mengirimkan command dengan format <code>market pilihan_nomor</code>\n\n#{list}"
end

def reminder_all
  "Sekaligus mengingatkan kepada Kakak-kakak semua untuk update datanya di tiny.cc/bukabandung
Lalu subscribe official channel Bukalapak Bandung juga yaa\n(https://t.me/joinchat/AAAAAFScH6zPovO-LR_9nQ)"
end
