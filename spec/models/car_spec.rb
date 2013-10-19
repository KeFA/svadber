require 'spec_helper'

describe Car do
  let(:car) { Car.new(cost_for_decorations: 500, cost_for_hour: 20, hours_count: 10, paid: 150) }
  subject { expenditure }

  it 'should add total cost to its json' do
    car.as_json[:cost].should == car.cost_for_decorations + car.cost_for_hour * car.hours_count
  end

  it 'should add remain_to_pay to its json' do
    car.as_json[:remain_to_pay].should == (car.cost_for_decorations + car.cost_for_hour * car.hours_count) - car.paid
  end
end
