class Oystercard

  DEFAULT_MAXIMUM = 90 
  MINIMUM_AMOUNT = 1

  attr_reader :balance
  attr_reader :on_journey

  def initialize(balance=0)
  @balance = balance
  @on_journey
  end

  def top_up(monies)
    @monies = monies 
    fail "Topping up this amount will take you over the £#{DEFAULT_MAXIMUM} maximum" if over_maximum?
    @balance += monies
  end

  def touch_in
    fail "You have insufficient funds to travel" if @balance < MINIMUM_AMOUNT
    @on_journey = true
  end

  def touch_out
    deduct_fare(MINIMUM_AMOUNT)
    @on_journey = false
  end

  def on_a_journey?
    @on_journey = false
  end

private 

  def over_maximum?
    @balance + @monies > DEFAULT_MAXIMUM
  end

  def deduct_fare(cash)
    @balance -= cash
  end

end