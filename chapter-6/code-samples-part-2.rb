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


# Listing 6.11, pg. 124

begin
  puts mountain_bike.spares
  #=> code-samples-part-2.rb:116:in `spares': super: no superclass method `spares' for #<MountainBike:0x00007fe02183f960> (NoMethodError)
rescue NoMethodError
  puts "code-samples-part-2.rb:116:in `spares': super: no superclass method `spares' for #<MountainBike:0x00007fe02183f960> (NoMethodError)"
end


# Listing 6.12, pg. 125

class Bicycle
  attr_reader :size

  def initialize(**opts)
    @size = opts[:size]
    @chain = opts[:chain]
    @tire_size = opts[:tire_size]
  end
end


# Listing 6.13, pg. 126

class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(**opts)
    @size = opts[:size]
    @chain = opts[:chain] || default_chain
    @tire_size = opts[:tire_size] || default_tire_size
  end

  def default_chain       # <- common default
    "11-speed"
  end
  # ...
end

class RoadBike < Bicycle
  # ...
  def default_tire_size   # <- subclass default
    "23"
  end
end

class MountainBike < Bicycle
  # ...
  def default_tire_size   # <- subclass default
    "2.1"
  end
end


# Listing 6.14, pg. 126-127

road_bike = RoadBike.new(
              size: 'M',
              tape_color: 'red')

puts road_bike.tire_size        #=> 23
puts road_bike.chain            #=> 11-speed

mountain_bike = MountainBike.new(
                  size: 'S',
                  front_shock: 'Manitou',
                  rear_shock: 'Fox')

puts mountain_bike.tire_size    #=> 2.1
puts mountain_bike.chain        #=> 11-speed


# Listing 6.15, pg. 127

class RecumbentBike < Bicycle
  def default_chain
    '10-speed'
  end
end

begin
  bent = RecumbentBike.new(size: 'L')
  #=> code-samples-part-2.rb:152:in `initialize': undefined local variable or method `default_tire_size' 
  #=> for #<RecumbentBike:0x00007f8026984d30 @size="L", @chain="10-speed"> (NameError)
rescue NameError
  puts "code-samples-part-2.rb:152:in `initialize': undefined local variable or method `default_tire_size' for #<RecumbentBike:0x00007f8026984d30 @size=\"L\", @chain=\"10-speed\"> (NameError)"
end


# Listing 6.16, pg. 128

class Bicycle
  # ...
  def default_tire_size
    raise NotImplementedError
  end
end


# Listing 6.17, pg. 128

begin
  bent = RecumbentBike.new(size: "L")
  #=> code-samples-part-2.rb:216:in `default_tire_size': NotImplementedError (NotImplementedError)
rescue NotImplementedError
  puts "code-samples-part-2.rb:216:in `default_tire_size': NotImplementedError (NotImplementedError)"
end


# Listing 6.18, pg. 128-129

class Bicycle
  # ...
  def default_tire_size
    raise NotImplementedError,
          "#{self.class} should have implemented..."
  end
end


# Listing 6.19, pg. 129

begin
  bent = RecumbentBike.new(size: "L")
  #=> code-samples-part-2.rb:236:in `default_tire_size': RecumbentBike should have implemented... (NotImplementedError)
rescue NotImplementedError
  puts "code-samples-part-2.rb:236:in `default_tire_size': RecumbentBike should have implemented... (NotImplementedError)"
end  


# Listing 6.20, pg. 130

class RoadBike < Bicycle
  # ...
  def spares
    { chain: '11-speed',
      tire_size: '23',
      tape_color: tape_color }
  end
end