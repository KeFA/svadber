module GuestsHelper
  def guests
    current_user.wedding.guests
  end

  def new_guest(params = {})
    guests.build(params)
  end
end