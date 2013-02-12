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

  describe 'wedding budget' do
    before { wedding.save }

    it 'should calculate total cost' do
      wedding.expenditures.create(cost: 200, )
      wedding.expenditures.create(cost: 500)
      wedding.expenditures.create(cost: 11)
      wedding.budget_cost.should == 200 + 500 + 11
    end

    it 'should calculate total paid' do
      wedding.expenditures.create(paid: 22)
      wedding.expenditures.create(paid: 27)
      wedding.budget_paid.should == 22 + 27
    end

    it 'should calculate remained to pay' do
      wedding.expenditures.create(cost: 100, paid: 22)
      wedding.expenditures.create(cost: 100, paid: 27)
      wedding.budget_to_pay.should == 200 - 49
    end

    it 'budget cost, paid should be zero if there is no expenditures' do
      wedding.budget_cost.should == 0
      wedding.budget_paid.should == 0
    end
  end
end

