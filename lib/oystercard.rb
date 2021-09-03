class Oystercard

  DEFAULT_MAXIMUM = 90 
  MINIMUM_AMOUNT = 1

  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :list_of_journeys
  attr_reader :journey


  def initialize(balance=0)
    @balance = balance
    @list_of_journeys = []
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

  def touch_out(exit_station)
    @exit_station = exit_station
    @journey = {@entry_station => @exit_station}
    @list_of_journeys << @journey
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