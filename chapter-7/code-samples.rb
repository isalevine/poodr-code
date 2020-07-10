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
  def scheduled?(schedulable, starting, ending)
    puts "This #{schedulable.class} is available #{starting} - #{ending}"
    false
  end
end


# Listing 7.3, pg. 149

class Bicycle
  attr_reader :schedule, :size, :chain, :tire_size

  # Inject the Schedule and provide a default
  def initialize(**opts)
    @schedule = opts[:schedule] || Schedule.new
    # ...
  end

  # Return true if this bicycle is available
  # during this (now Bicycle specific) interval.
  def schedulable?(starting, ending)
    !scheduled?(starting - lead_days, ending)
  end

  # Return the schedule's answer
  def scheduled?(starting, ending)
    schedule.scheduled?(self, starting, ending)
  end

  # Return the number of lead_days before a bicycle
  # can be schduled.
  def lead_days
    1
  end
  # ...
end

require 'date'
starting = Date.parse("2019/09/04")
ending = Date.parse("2019/09/10")

b = Bicycle.new
puts b.schedulable?(starting, ending)
#=> This Bicycle is available 2019-09-03 - 2019-09-10
#=> true


# Listing 7.4, pg. 150

module Schedulable
  attr_writer :schedule

  def schedule
    @schedule ||= Schedule.new
  end

  def schedulable?(starting, ending)
    !scheduled?(starting - lead_days, ending)
  end

  def scheduled?(starting, ending)
    schedule.scheduled?(self, starting, ending)
  end

  # includers may override
  def lead_days
    0
  end
end


# Listing 7.5, pg. 151

class Bicycle
  include Schedulable
  
  def lead_days
    1
  end
  # ...
end

require 'date'
starting = Date.parse("2019/09/04")
ending = Date.parse("2019/09/10")

b = Bicycle.new
puts b.schedulable?(starting, ending)
#=> This Bicycle is available 2019-09-03 - 2019-09-10
#=> true


# Listing 7.6, pg. 152-153

class Vehicle
  include Schedulable
  
  def lead_days
    3
  end
  # ...
end

class Mechanic
  include Schedulable

  def lead_days
    4
  end
  # ...
end

v = Vehicle.new
puts v.schedulable?(starting, ending)
#=> This Vehicle is available 2019-09-01 - 2019-09-10
#=> true

m = Mechanic.new
puts m.schedulable?(starting, ending)
#=> This Mechanic is available 2019-08-31 - 2019-09-10
#=> true
