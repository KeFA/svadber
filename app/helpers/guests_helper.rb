module GuestsHelper
  def guests
    current_user.wedding.guests
  end

  def new_guest(params = {})
    guests.build(params)
  end

  def guest_statuses
    statuses = guests.collect { |guest| guest.status or '' }
    statuses << t(:fiance) << t(:fiancee) << t(:witnesses) << t(:fiance_parents) << t(:fiancee_parents)
    statuses.uniq.sort
  end
end