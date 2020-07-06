# Listing 7.1, pg. 144

class Schedule
  def scheduled?(schedulable, starting, ending)
    # ...
  end

  def add(target, starting, ending)
    # ...
  end

  def remove(target, starting, ending)
    # ...
  end
end


# Listing 7.2, pg. 148

class Schedule
  def scheduled?(schedulable, starting, ending)\
    puts "This #{schedulable.class} is available #{starting} - #{ending}"
    false
  end
end
