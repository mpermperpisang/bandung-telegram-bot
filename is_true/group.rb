# Untuk memeriksa apakah grup private atau supergroup/umum
class Group
  def not_private_chat?(group)
    type = %w[group supergroup]
    return true if type.include?(group)
  end
end
