require 'spec_helper'

describe Guest do
  before { @guest = Guest.new(last_name: 'Sinkevich', first_name: 'Maryia', middle_name: 'Sergeevna',
                          city: 'Bobryisk', status: 'guest') }
  subject { @guest }

  it { should be_valid }

  describe 'when last name is empty' do
    before { @guest.last_name = '  ' }
    it { should_not be_valid }
  end
end