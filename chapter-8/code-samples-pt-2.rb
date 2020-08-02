# Listing 8.10, pg. 173

class Parts < Array
  def spares
    select { |part| part.needs_spare }
  end
end


# copied code from part 1 (moved to prevent conflicts with Parts inheriting from Array or not)

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

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(name:, description:, needs_spare: true)
    @name = name
    @description = description
    @needs_spare = needs_spare
  end
end

chain = Part.new(name: "chain", description: "11-speed")
road_tire = Part.new(name: "tire_size", description: "23")
tape = Part.new(name: "tape_color", description: "red")
mountain_tire = Part.new(name: "tire_size", description: "2.1")
rear_shock = Part.new(name: "rear_shock", description: "Fox", needs_spare: false)
front_shock = Part.new(name: "front_shock", description: "Manitou")

road_bike_parts = Parts.new([chain, road_tire, tape])
mountain_bike_parts = Parts.new([chain, mountain_tire, front_shock, rear_shock])

road_bike = Bicycle.new(size: "L", parts: Parts.new([chain, road_tire, tape]))
mountain_bike = Bicycle.new(size: "L", parts: Parts.new([chain, mountain_tire, front_shock, rear_shock]))


# Listing 8.11, pg. 174

# Parts inherits `+` from Array, so you can
# add two Parts together
combo_parts = (mountain_bike.parts + road_bike.parts)

puts mountain_bike.parts.class  #=> Parts
puts road_bike.parts.class      #=> Parts
puts combo_parts.class          #=> Array

# `+` definitely combines the Parts...
puts combo_parts.size           #=> 7

# ...but the object that `+` returns
# does not understand `spares`
begin
  puts combo_parts.spares         #=> code-samples-pt-2.rb:73:in `<main>': undefined method `spares' for #<Array:0x00007fa4cb098540> (NoMethodError)
rescue NoMethodError
  puts "code-samples-pt-2.rb:73:in `<main>': undefined method `spares' for #<Array:0x00007fa4cb098540> (NoMethodError)"
end


# Listing 8.12, pg. 175

require 'forwardable'

class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each
  include Enumerable

  def initialize(parts)
    @parts = parts
  end

  def spares
    select { |part| part.needs_spare }
  end
end


# Listing 8.13, pg. 176

road_bike = Bicycle.new(size: "L", parts: Parts.new([chain, road_tire, tape]))
mountain_bike = Bicycle.new(size: "L", parts: Parts.new([chain, mountain_tire, front_shock, rear_shock]))

puts mountain_bike.spares.size    #=> 0   <- output should be 3 according to book!!
puts mountain_bike.parts.size     #=> 4

puts mountain_bike.parts + road_bike.parts
#=> no output   <- should return a NoMethodError for class Parts on `+`

# using byebug, it appears that neither the mountain_bike nor road_bike Bicycle instances
# keep their passed-in Part instances in their `parts` attribute -- `parts` is [] instead!!


# Listing 8.14, pg. 177

road_config = 
  [['chain', '11-speed'],
   ['tire_size', '23'],
   ['tape_color', 'red']]

mountain_config = 
  [['chain', '11-speed'],
   ['tire_size', '2.1'],
   ['front_shock', 'Manitou'],
   ['rear_shock', 'Fox', false]]
   
  
# Listing 8.15, pg. 178

module PartsFactory
  def self.build(config:, part_class: Part, parts_class: Parts)
    parts_class.new(
      config.collect {|part_config|
        part_class.new(
          name:         part_config[0],
          description:  part_config[1],
          needs_spare:  part_config.fetch(2, true)
        )
      }
    )
  end
end


# Listing 8.16, pg. 178-179

puts PartsFactory.build(config: road_config).inspect
#=> []    <- same issue as output in Listing 8.13, this should be a Parts instance containing a bunch of Part instances!

puts PartsFactory.build(config: mountain_config).inspect
#=> []    <- same issue as output in Listing 8.13, this should be a Parts instance containing a bunch of Part instances!
