require 'spec_helper'

describe 'Budget page' do
  subject { page }
  before do
    user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user, email: 'example@test.org')
    sign_in user
    @wedding = user.weddings.create
    @other_wedding = other_user.weddings.create
  end

  describe 'index page' do
    before do
      FactoryGirl.create(:expenditure, wedding_id: @wedding.id, description: 'expenditure 1')
      FactoryGirl.create(:expenditure, wedding_id: @wedding.id, description: 'expenditure 2')
      FactoryGirl.create(:expenditure, wedding_id: @other_wedding.id, description: 'expenditure from other user')

      visit budget_path
    end

    it { should have_content 'expenditure 1' }
    it { should have_content 'expenditure 2' }
    it { should_not have_content 'expenditure from other user' }
  end
end
