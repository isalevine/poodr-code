# Listing 6.5, pg. 119

class Bicycle
  # This class is empty except for initialize.
  # Code has been moved to RoadBike.
  def initialize(**opts)
  end
end


class RoadBike < Bicycle
  # Now a subclass of Bicycle.
  # Contains all code from the old Bicycle class.

  attr_reader :size, :tape_color

  def initialize(**opts)
    @size = opts[:size]
    @tape_color = opts[:tape_color]
  end

  # every bike has the same defaults for
  # tire and chain size
  def spares
    { chain: '11-speed',
      tire_size: '23',
      tape_color: tape_color }
  end

  # Many other methods...
end


class MountainBike < Bicycle
  # Still a subclass of Bicycle.
  # Code has not changed.

  attr_reader :front_shock, :rear_shock

  def initialize(**opts)
    @front_shock = opts[:front_shock]
    @rear_shock = opts[:rear_shock]
    super
  end

  def spares
    super.merge(front_shock: front_shock)
  end
end


# Listing 6.6, pg. 120

road_bike = RoadBike.new(size: 'M', tape_color: 'red')
puts road_bike.size
#=> M

begin
  mountain_bike = MountainBike.new(size: 'S', front_shock: 'Manitou', rear_shock: 'Fox')
  puts mountain_bike.size
  #=> code-samples-part-2.rb:59:in `<main>': undefined method `size' for #<MountainBike:0x00007fbc41019140> (NoMethodError)
rescue NoMethodError
  puts "code-samples-part-2.rb:59:in `<main>': undefined method `size' for #<MountainBike:0x00007fbc41019140> (NoMethodError)"
end

# Listing 6.7, pg. 121

class Bicycle
  attr_reader :size       # <- promoted from RoadBike

  def initialize(**opts)
    @size = opts[:size]   # <- promoted from RoadBike
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def initialize(**opts)
    @tape_color = opts[:tape_color]
    super   # <- RoadBike MUST send `super`
  end
  # ...
end


# Listing 6.8, pg. 121-122

road_bike = RoadBike.new(size: 'M', tape_color: 'red')
mountain_bike = MountainBike.new(size: 'S', front_shock: 'Manitou', rear_shock: 'Fox')

puts road_bike.size
#=> M

puts mountain_bike.size
#=> S


# Listing 6.9, pg. 123

class RoadBike < Bicycle
  # ...
  def spares
    { chain: '11-speed',
      tire_size: '23',
      tape_color: tape_color }
  end
end


# Listing 6.10, pg. 124

class MountainBike < Bicycle
  # ...
  def spares
    super.merge(front_shock: front_shock)
  end
end
