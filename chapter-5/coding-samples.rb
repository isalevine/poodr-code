# Listing 5.1, pg. 87

class Trip
  attr_reader :bicycles, :customers, :vehicle

  # this 'mechanic' argument could be any class
  def prepare(mechanic)
    mechanic.prepare_bicycles(bicycles)
  end

  # ...
end

# if you happen to pass an instance of *this* class,
# it works
class Mechanic
  def prepare_bicycles(bicycles)
    bicycles.each { |bicycle| prepare_bicycle(bicycle) }
  end

  def prepare_bicycle(bicycle)
    # ...
  end
end


# Listing 5.2, pg. 88-89

# Trip preparation becomes more complicated
class Trip
  attr_reader :bicycles, :customers, :vehicles

  def prepare(preparers)
    preparers.each { |preparer|
      case preparer
      when Mechanic
        preparer.prepare_bicycles(bicycles)
      when TripCoordinator
        preparer.buy_food(customers)
      when Driver
        preparer.gas_up(vehicle)
        preparer.fill_water_tank(vehicle)
      end
    }
  end
end

# when you introduce TripCoordinator and Driver
class TripCoordinator
  def buy_food(customers)
    # ...
  end
end

class Driver
  def gas_up(vehicle)
    # ...
  end

  def fill_water_tank(vehicle)
    # ...
  end
end


# Listing 5.3, pg. 93

# Trip preparation becomes easier
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each { |preparer| preparer.prepare_trip(self) }
  end
  # ...
end

# when every preparer is a Duck
# that responds to 'prepare_trip'
class Mechanic
  def prepare_trip(trip)
    trip.bicycles.each { |bicycle| prepare_bicycle(biycle) }
  end
  # ...
end

class TripCoordinator
  def prepare_trip(trip)
    buy_food(trip.customers)
  end
  # ...
end

class Driver
  def prepare_trip(trip)
    vehicle = trip.vehicle
    gas_up(vehicle)
    fill_water_tank(vehicle)
  end
  # ...
end


# Listing 5.4, pg. 96

# The following can be replaced by a `preparer` duck,
# all of which respond to a `prepare_trip` method.

# This shifts the responsibility of knowing what each type does
# from Trip (which currently must know each class, and their methods)
# to the `preparer` duck, so that only the class itself knows what
# `prepare_trip` needs to do.

# "The ability to tolerate ambiguity about the class of an object
# is the hallmark of a confident designer. Once you begin to treat
# your obhects as if they are defined by their behavior rather than
# their class, you enter into a new realm of expressive flexible 
# design." - Listing 5.1.4, pg. 94

class Trip
  def prepare(preparers)
    preparers.each { |preparer|
      case preparer
      when Mechanic
        preparer.prepare_bicycles(bicycles)
      when TripCoordinator
        preparer.buy_food(customers)
      when Driver
        preparer.gas_up(vehicle)
        preparer.fill_water_tank(vehicle)
      end
    }
  end
  # ...
end


# Listing 5.5, pg. 96

  if preparer.kind_of?(Mechanic)
    preparer.prepare_bicycles(bicycles)
  elsif preparer.kind_of?(TripCoordinator)
    preparer.buy_food(customers)
  elsif preparer.kind_of?(Driver)
    preparer.gas_up(vehicle)
    preparer.fill_water_tank(vehicle)
  end


# Listing 5.6, pg. 97

  if preparer.respond_to?(:prepare_bicycles)
    preparer.prepare_bicycles(bicycles)
  elsif preparer.responds_to?(:buy_food)
    preparer.buy_food(customers)
  elsif preparer.responds_to?(:gas_up)
    preparer.gas_up(vehicle)
    preparer.fill_water_tank(vehicle)
  end


# Listing 5.7, pg. 99

def find_with_ids(*ids)
  raise UnknownPrimaryKey.new(@klass) if primary_key.nil?

  expects_array = ids.first.kind_of?(array)
  return ids.first if expects_array && ids.first.empty?

  ids = ids.flatten.compact.uniq

  case ids.size
  when 0
    raise RecordNotFound, "Couldn't find #{@klass.name} without an ID"
  when 1
    result = find_one(ids.first)
    expects_array ? [ result ] : result
  else
    find_some(ids)
  end
rescue ::RangeError
  raise RecordNotFound, "Couldn't find #{@klass.name} with an out of range ID"
end
