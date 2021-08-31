class Oystercard

  attr_reader :balance

  def initialize(balance=0)
  @balance = balance
  end

  def top_up(monies)
    @balance += monies
  end

end