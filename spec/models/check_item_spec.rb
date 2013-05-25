require 'spec_helper'

describe CheckItem do
  let(:check_item) { FactoryGirl.create(:check_item) }

  subject { check_item }

  it { should be_valid }
  it { should respond_to :done }
  it { should respond_to :description }
  it { should respond_to :wedding }
end
