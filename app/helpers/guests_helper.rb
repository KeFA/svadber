module GuestsHelper
  def guest_statuses
    statuses = @guests.collect { |guest| guest.status or '' }
    statuses << t(:fiance) << t(:fiancee) << t(:witnesses) << t(:fiance_parents) << t(:fiancee_parents)
    statuses.uniq.sort
  end
end