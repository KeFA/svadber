require 'spec_helper'

describe 'Guests pages' do
  subject { page }

  describe 'index page' do
    before do
      user = FactoryGirl.create(:user)
      sign_in user

      wedding = user.weddings.create
      FactoryGirl.create(:guest, last_name: 'Sinkevich', wedding_id: wedding.id)
      FactoryGirl.create(:guest, last_name: 'Rudzko', wedding_id: wedding.id)

      visit guestslist_path
    end

    #todo: da
    #it { should have_content 'Sinkevich' }
    #it { should have_content 'Rudzko' }
  end
end