require 'spec_helper'

describe 'Guests pages' do
  subject { page }

  describe 'index page' do
    before do
      FactoryGirl.create(:guest, last_name: 'Sinkevich')
      FactoryGirl.create(:guest, last_name: 'Rudzko')
      visit guests_path
    end

    it { should have_content 'Sinkevich' }
    it { should have_content 'Rudzko' }


    describe 'add a guest' do
      describe 'with valid information' do
        before do
          visit guests_path
          fill_in 'guest_last_name', with: 'Sinkevich'
          fill_in 'guest_first_name', with: 'Maryia'
          fill_in 'guest_middle_name', with: 'Sergeevna'
          fill_in 'guest_city', with: 'Bobryisk'
          fill_in 'guest_status', with: 'guest'
        end

        it 'should create a guest' do
          expect { click_button 'add_guest' }.to change(Guest, :count).by(1)
        end

        it 'should have the new guest in the list' do
          click_button 'add_guest'

          page.should have_content 'Maryia'
          page.should have_content 'Sergeevna'
        end
      end

      describe 'with invalid information' do
        before do
          click_button 'add_guest'
        end

        it { should have_selector('div.alert.alert-error') }
      end
    end
  end
end