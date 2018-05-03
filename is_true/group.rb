<<<<<<< HEAD
# Untuk memeriksa apakah grup private atau supergroup/umum
class Group
  def not_private_chat?(group)
    type = %w[group supergroup]
    return true if type.include?(group)
=======
class Group
  def is_not_private?(group)
    unless group == "group" || group == "supergroup"
      bot_group = false
    else
      bot_group = true
    end
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
  end
end
