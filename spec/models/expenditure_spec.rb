require 'spec_helper'

describe Expenditure do
  let(:expenditure) { Expenditure.new(wedding_id: 1) }
  subject { expenditure }

  it { should be_valid }
  it 'add remain_to_pay to its json' do
    expenditure.cost = 500
    expenditure.paid = 200
    expenditure.as_json[:remain_to_pay].should == 500 - 200
  end
end
