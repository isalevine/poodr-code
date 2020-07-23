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
  attr_reader :name, :description, :needs_spares

  def initialize(name:, description:, needs_spares: true)
    @name = name
    @description = description
    @needs_spares = needs_spares
  end
end

chain = Part.new(name: "chain", description: "11-speed")
road_tire = Part.new(name: "tire_size", description: "23")
tape = Part.new(name: "tape_color", description: "red")
mountain_tire = Part.new(name: "tire_size", description: "2.1")
rear_shock = Part.new(name: "rear_shock", description: "Fox", needs_spares: false)
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