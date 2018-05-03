class Group
  def is_not_private?(group)
    unless group == "group" || group == "supergroup"
      bot_group = false
    else
      bot_group = true
    end
  end
end
