require 'spec_helper'

describe Wedding do
  before { @wedding = Wedding.new(user_id: 1) }
  subject { @wedding }

  it { should respond_to(:user) }
end
