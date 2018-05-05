def empty_staging(command, user)
  "@#{user} forgot to type staging name 😒\nExample: <code>#{command}_103</code>"
end

def chat_not_found
  'Jenkins chat not found, please check @mpermperpisang'
end

def msg_block_deploy(user)
  "Please book the staging first, @#{user}"
end

def mention_admin
  'Colek Kak @mpermperpisang'
end

def send_off(bot)
  "#{bot} offline, please check @mpermperpisang"
end

def empty_branch(comm, user)
  "@#{user} forgot to type the branch 😒\nExample: <code>#{comm} master</code>"
end

def new_staging(name, staging)
  "<code>staging#{staging}.vm</code> staging baru yaa, Kak @#{name}?
Bilang ke Kak @mpermperpisang dulu yaa buat ditambahin ke daftar 😉"
end

def error_deploy(user, staging, name)
  "@#{user} did not booking <code>staging#{staging}</code> but trying to deploy into it\nFYI @#{name}"
end

def error_staging(user)
  "Bukan staging milik squad BBM, @#{user}"
end

def error_dev(user)
  "Sorry @#{user}, only BE or FE can request deploy to staging"
end

def error_qa(user)
  "Sorry @#{user}, you're not QA or at least you're not added in QA list yet 😬
Private message @mpermperpisang, please
Or maybe you want to try other features such like /lock, /start, /restart, /stop, /migrate, /reindex or /precompile ☺️"
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
  "Sekarang aku lagi ngga deploy apa-apa, Kak @#{user}"
end

def blocked_bot(user)
  "#{user} ngeblock botnya, please check @mpermperpisang"
end

def welcome_text(user)
  "Selamat datang, #{user}\nSilahkan ketik /help untuk tahu informasi lebih lanjut yaa"
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
  "List of deploy requests :\n\n#{list}\n\n@mpermperpisang @rezaldy08"
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

def not_member_market
  'Kakak belum terdaftar untuk ikut marketplace\nCoba tanya ke Kak @mpermperpisang ajah yaa'
end

def empty_edit(error)
  "There is no message to edit, please check @mpermperpisang\n#{error}"
end

def list_poin_market(poin)
  "Poin for marketplace\n======================================\n#{poin}\n
colek @ak_fahmi @Maharaniar"
end

def empty_poin
  'Belum ada orang yang memberikan poin untuk marketplace'
end

def msg_new_poin_member
  "Menampilkan poin\nSilahkan cek rame-rame di grup BBM Bot Announcements yaa\n
Kloter sudah dibuka, tunggu aba-aba dari PM/APM yaa"
end

def msg_new_poin
  "Menampilkan poin\nSilahkan cek rame-rame di grup BBM Bot Announcements yaa"
end

def done_poin(poin)
  "Yang sudah memberikan poin:\n#{poin}\n\nKalau sudah selesai, klik /show yaa, Kak"
end

def show_command
  "Daripada capek ngetik terus, mending klik /show (untuk menampilkan poin) atau klik /keyboard (untuk menampilkan poin), Kak
Have a nice marketplace ☺️"
end
