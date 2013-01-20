require 'spec_helper'

describe Guest do
  before do
    @guest = Guest.new(wedding_id: 1)
  end
  subject { @guest }

  it { should be_valid }
end