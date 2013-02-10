require 'spec_helper'

describe Expenditure do
  let(:expenditure) { Expenditure.new(wedding_id: 1) }
  subject { expenditure }

  it { should be_valid }
  it { should respond_to(:remain_to_paid) }
  it 'should calculate balance to pay' do
    expenditure.cost = 500
    expenditure.paid = 200
    expenditure.remain_to_paid.should == 500 - 200
  end
end
