require 'journey'

class Oystercard
  attr_reader :balance, :journeys

  MAX_BALANCE = 90
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @journeys = []
  end

  def add_money(money)
    check_if_max_balance_exceeded(money)
    @balance += money
  end
  
  # def in_journey?
  #   entry_station == nil ? false : true
  #  # Alternativly use Double Bang!
  #  # !!entry_station
  # end
  
  def touch_in(entry_station)
    check_min_balance
    (deduct_money(PENALTY_FARE) unless @journeys.last.journey_complete?) unless @journeys.empty? 
    @journeys << Journey.new
    @journeys.last.start_journey(entry_station)
  end
  
  def touch_out(exit_station)
    if @journeys.empty?
      deduct_money(PENALTY_FARE)
      @journeys << Journey.new
      @journeys.last.finish_journey(exit_station)
    elsif @journeys.last.journey_complete?
      deduct_money(PENALTY_FARE)
      @journeys << Journey.new
      @journeys.last.finish_journey(exit_station)
    else 
      @journeys.last.finish_journey(exit_station)
      deduct_money(@journeys.last.calculate_fare)
    end 
  end
  
  def journey_log
    @journeys.map{ |journey| journey.information }
  end

  private
  
  def check_min_balance
    fail 'Insufficient balance' unless @balance >= MIN_FARE
  end

  def deduct_money(money)
    @balance -= money
  end
  
  def check_if_max_balance_exceeded(money)
    fail "funds cannot be added: maximum balance £#{MAX_BALANCE}" if @balance + money > MAX_BALANCE
  end
  
end
