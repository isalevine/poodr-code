# Listing 8.1, pg. 165

class Bicycle
  attr_reader :size, :parts

  def initialize(size:, parts:)
    @size = size
    @parts = parts
  end

  def spares
    parts.spares
  end
end


# Listing 8.2, pg. 165-166

class Parts
  attr_reader :chain, :tire_size

  def initialize(**opts)
    @chain = opts[:chain] || default_chain
    @tire_size = opts[:tire_size] || default_tire_size
    post_initialize(opts)
  end

  def spares
    { chain: chain,
      tire_size: tire_size }.merge(local_spares)
  end

  def default_tire_size
    raise NotImplementedError
  end

  # subclasses may override
  def post_initialize(opts)
    nil
  end

  def local_spares
    {}
  end

  def default_chain
    "11-speed"
  end
end


class RoadBikeParts < Parts
  attr_reader :tape_color

  def post_initialize(**opts)
    @tape_color = opts[:tape_color]
  end

  def local_spares
    { tape_color: tape_color }
  end

  def default_tire_size
    "23"
  end
end


class MountainBikeParts < Parts
  attr_reader :front_shock, :rear_shock

  def post_initialize(**opts)
    @front_shock = opts[:front_shock]
    @rear_shock = opts[:rear_shock]
  end

  def local_spares
    { front_shock: front_shock }
  end

  def default_tire_size
    "2.1"
  end
end


# Listing 8.3, pg. 167

road_bike = Bicycle.new(size: "L", parts: RoadBikeParts.new(tape_color: "red"))
puts road_bike.size
#=> L
puts road_bike.spares
#=> {:chain=>"11-speed", :tire_size=>"23", :tape_color=>"red"}

mountain_bike = Bicycle.new(size: "L", parts: MountainBikeParts.new(front_shock: "Manitou", rear_shock: "Fox"))
puts mountain_bike.size
#=> L
puts mountain_bike.spares
#=> {:chain=>"11-speed", :tire_size=>"2.1", :front_shock=>"Manitou"}


# Listing 8.4, pg. 169-170

class Bicycle
  attr_reader :size, :parts

  def initialize(size:, parts:)
    @size = size
    @parts = parts
  end

  def spares
    parts.spares
  end
end


class Parts
  attr_reader :parts
  
  def initialize(parts)
    @parts = parts
  end

  def spares
    parts.select { |part| part.needs_spare }
  end
end


class Part
  attr_reader :name, :description, :needs_spare

  def initialize(name:, description:, needs_spare: true)
    @name = name
    @description = description
    @needs_spare = needs_spare
  end
end


# Listing 8.5, pg. 170-171

chain = Part.new(name: "chain", description: "11-speed")
road_tire = Part.new(name: "tire_size", description: "23")
tape = Part.new(name: "tape_color", description: "red")
mountain_tire = Part.new(name: "tire_size", description: "2.1")
rear_shock = Part.new(name: "rear_shock", description: "Fox", needs_spare: false)
front_shock = Part.new(name: "front_shock", description: "Manitou")


# Listing 8.6, pg. 171

road_bike_parts = Parts.new([chain, road_tire, tape])

mountain_bike_parts = Parts.new([chain, mountain_tire, front_shock, rear_shock])


# Listing 8.7, pg. 171-172

road_bike = Bicycle.new(size: "L", parts: Parts.new([chain, road_tire, tape]))

puts road_bike.size
#=> L

puts road_bike.spares.inspect
#=> [ #<Part:0x00007fee3f1095c0 @name="chain", @description="11-speed", @needs_spare=true>, 
#=>   #<Part:0x00007fee3f1094f8 @name="tire_size", @description="23", @needs_spare=true>, 
#=>   #<Part:0x00007fee3f109430 @name="tape_color", @description="red", @needs_spare=true> ]


mountain_bike = Bicycle.new(size: "L", parts: Parts.new([chain, mountain_tire, front_shock, rear_shock]))

puts mountain_bike.size
#=> L

puts mountain_bike.spares.inspect
#=> [ #<Part:0x00007ffd0692d3e8 @name="chain", @description="11-speed", @needs_spare=true>, 
#=>   #<Part:0x00007ffd0692d190 @name="tire_size", @description="2.1", @needs_spare=true>, 
#=>   #<Part:0x00007ffd0692d000 @name="front_shock", @description="Manitou", @needs_spare=true> ]


# Listing 8.8, pg. 173

puts mountain_bike.spares.size
#=> 3

begin
  puts mountain_bike.parts.size
  #=> code-samples.rb:188:in `<main>': undefined method `size' for #<Parts:0x00007fbb97994648> (NoMethodError)
rescue NoMethodError
  puts "code-samples.rb:188:in `<main>': undefined method `size' for #<Parts:0x00007fbb97994648> (NoMethodError)"
end


# Listing 8.9, pg. 173

# code within Parts
  def size
    parts.size
  end
  