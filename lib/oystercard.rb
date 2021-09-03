class Oystercard

  DEFAULT_MAXIMUM = 90 
  MINIMUM_AMOUNT = 1

  attr_reader :balance
  attr_reader :entry_station

  def initialize(balance=0)
  @balance = balance
  #@on_journey = false
  end

  def top_up(monies)
    @monies = monies 
    fail "Topping up this amount will take you over the £#{DEFAULT_MAXIMUM} maximum" if over_maximum?
    @balance += monies
  end

  def touch_in(entry_station)
    @entry_station = entry_station
    fail "You have insufficient funds to travel" if @balance < MINIMUM_AMOUNT
  end

  def touch_out
    deduct_fare(MINIMUM_AMOUNT)
    @entry_station = nil 
  end

  def on_a_journey?
    !!entry_station
  end

private 

  def over_maximum?
    @balance + @monies > DEFAULT_MAXIMUM
  end

  def deduct_fare(cash)
    @balance -= cash
  end

end