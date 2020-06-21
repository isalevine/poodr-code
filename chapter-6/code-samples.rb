# Listing 6.1, pg 107-108

class Bicycle
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

bike = Bicycle.new(size: 'M', tape_color: 'red')
puts bike.size
#=> M

puts bike.spares
#=> {:chain=>"11-speed", :tire_size=>"23", :tape_color=>"red"}


# Listing 6.2, pg. 109-110

class Bicycle
  attr_reader :style, 
              :size, 
              :tape_color, 
              :front_shock, 
              :rear_shock

  def initialize(**opts)
    @style = opts[:style]
    @size = opts[:size]
    @tape_color = opts[:tape_color]
    @front_shock = opts[:front_shock]
    @rear_shock = opts[:rear_shock]
  end

  # checking 'style' starts down a slippery slope
  def spares
    if style == :road
      { chain: '11-speed', 
        tire_size: '23',    # millimeters
        tape_color: tape_color }
    else
      { chain: '11-speed',
        tire_size: '2.1',   # inches
        front_shock: front_shock }
    end
  end
  # ...
end

bike = Bicycle.new(
  style: :mountain,
  size: 'S',
  front_shock: 'Manitou',
  rear_shock: 'Fox')

puts bike.spares
#=> {:chain=>"11-speed", :tire_size=>"2.1", :front_shock=>"Manitou"}

bike = Bicycle.new(
  style: :road,
  size: 'M',
  tape_color: 'red')

puts bike.spares
#=> {:chain=>"11-speed", :tire_size=>"23", :tape_color=>"red"}


# Listing 6.3, pg. 115

class MountainBike < Bicycle
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


# Listing 6.4, pg. 115

# reset to original Bicycle class from listing 6.1
class Bicycle
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

mountain_bike = MountainBike.new(
                  size: 'S', 
                  front_shock: 'Manitou', 
                  rear_shock: 'Fox')

puts mountain_bike.size
#=> S

puts mountain_bike.spares
#=> {:chain=>"11-speed", 
#    :tire_size=>"23",        <- wrong!
#    :tape_color=>nil,        <- not applicable!
#    :front_shock=>"Manitou"}
