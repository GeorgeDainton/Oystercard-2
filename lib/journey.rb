class Journey

  MIN_FARE = 1

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
    MIN_FARE
  end

end