class Oystercard

  DEFAULT_MAXIMUM = 90 
  DEFAULT_FARE = 2

  attr_reader :balance

  def initialize(balance=0)
  @balance = balance
  end

  def top_up(monies)
    @monies = monies 
    fail "Topping up this amount will take you over the £#{DEFAULT_MAXIMUM} maximum" if over_maximum?
    @balance += monies
  end

  def deduct_fare
    @balance -= DEFAULT_FARE
  end

private 

  def over_maximum?
    @balance + @monies > DEFAULT_MAXIMUM
  end

end