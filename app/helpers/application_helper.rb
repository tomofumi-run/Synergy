module ApplicationHelper
  
  def full_title(title = "")
    base = "Synergy"
      if admin_signed_in?
        base + " | " + "管理者用 #{title}"
      else
        base + " | " + "#{title}"
      end
  end
  
  def full_name(user)
    user.last_name + user.first_name
  end
end
