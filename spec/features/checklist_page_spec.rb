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
    before { visit checklist_index_path }

    it 'should contain all check items' do
      25.times do |i|
        page.should have_content "check item #{i}"
      end
    end

    it 'should contain update url for each check item' do
      page.all('.model_update_url').each_with_index do |el, i|
        el.value.should == "/checklist/#{i + 1}"
      end
    end
  end
end

