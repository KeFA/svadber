require 'spec_helper'

describe 'Checklist page' do
  subject { page }
  before do
    wedding = FactoryGirl.create(:wedding)
    user = wedding.user
    sign_in user

    25.times do |i|
      FactoryGirl.create(:check_item, wedding: wedding, description: "check item #{i}")
    end

  end

  describe 'index page' do
    before { visit checklist_path }

    it 'should contain all check items' do
      25.times do |i|
        page.should have_content "check item #{i}"
      end
    end
  end
end

