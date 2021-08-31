require 'oystercard'

describe Oystercard do

it {is_expected.to respond_to(:top_up).with(1).argument}

describe "#top_up" do
  it "should add money to oyster card" do 
  expect(subject.top_up(100)).to eq(subject.balance)
  end 
end

describe "#balance" do
  it "should start with a balance of zero" do
  expect(subject.balance).to eq(0)
  end
end


end