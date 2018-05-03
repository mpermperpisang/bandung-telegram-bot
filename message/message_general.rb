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
end

def list_deployment(list, user)
  "Sekarang aku lagi nge-deploy daftar ini ke staging, Kak @#{user}\nMohon bersabar yaa 😚\n\n#{list}"
end

def empty_deployment(user)
  "Sekarang aku lagi ngga deploy apa-apa, Kak @#{user}"
end
