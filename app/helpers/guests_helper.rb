module GuestsHelper
  def guests
    current_user.wedding.guests
  end

  def guest_cities
    cities = guests.collect { |guest| guest.city or '' }
    cities.uniq.sort
  end

  def guest_statuses
    statuses = guests.collect { |guest| guest.status or '' }
    statuses << t(:fiance) << t(:fiancee) << t(:witnesses) << t(:fiance_parents) << t(:fiancee_parents)
    statuses.uniq.sort
  end
end