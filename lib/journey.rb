class Journey

  MIN_FARE = 1
  PENALTY_FARE = 6

  attr_reader :information

  def initialize

    @information = {}

  end

  def start_journey(entry_station)
    @information[:entry_station] = entry_station
  end

  def finish_journey(exit_station)
    @information[:exit_station] = exit_station
  end

  def calculate_fare
    if @information[:entry_station] == nil || @information[:exit_station] == nil 
      PENALTY_FARE
    else
      MIN_FARE
    end
  end

  def journey_complete?
    if @information[:entry_station] != nil && @information[:exit_station] != nil
      true
    else
      false
    end
  end 

end