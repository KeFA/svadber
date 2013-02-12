module ApplicationHelper
  def current_wedding
    current_user.wedding
  end
end
