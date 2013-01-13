require 'spec_helper'

describe 'Guests pages' do
  subject { page }

  describe 'index page' do
    before { visit guests_path }

    let(:guest_1) { FactoryGirl.create(:guest) }
    let(:guest_2) { FactoryGirl.create(:guest) }

    it { should have_content(text: guest_1.last_name) }
    it { should have_content(text: guest_2.last_name) }

  end
end