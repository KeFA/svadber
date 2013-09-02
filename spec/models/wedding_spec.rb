require 'spec_helper'

describe Wedding do
  let(:wedding) { Wedding.new(user_id: 1) }
  subject { wedding }

  it { should respond_to(:user) }

  it 'should have one empty expenditure after create' do
    wedding.save
    wedding.save
    wedding.expenditures.count.should == 1
    wedding.expenditures.first.cost.should == 0
    wedding.expenditures.first.paid.should == 0
  end
end

