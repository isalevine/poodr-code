# Listing 2.1, pg. 18

chainring = 52
cog = 11
ratio = chainring / cog.to_f
puts ratio  #=> 4.7272727272727275


# Listing 2.2, pg. 19

class Gear
  attr_reader :chainring, :cog
  
  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def ratio
    chainring / cog.to_f
  end
end

puts Gear.new(52, 11).ratio   #=> 4.7272727272727275
puts Gear.new(30, 27).ratio   #=> 1.1111111111111112


# Listing 2.3, pg. 20

class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    # tire goes around rim twice for diameter
    ratio * (rim + (tire * 2))
  end
end

puts Gear.new(52, 11, 26, 1.5).gear_inches    #=> 137.0909090909091
puts Gear.new(52, 11, 24, 1.25).gear_inches   #=> 125.27272727272728


# Listing 2.4, pg. 21

begin
  puts Gear.new(52, 11).ratio
  #=> code-samples.rb:33:in `initialize': wrong number of arguments (given 2, expected 4) (ArgumentError)
rescue ArgumentError
  puts "code-samples.rb:33:in `initialize': wrong number of arguments (given 2, expected 4) (ArgumentError)"
end

# Listing 2.5, pg. 24

class Gear
  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def ratio
    @chainring / @cog.to_f    # <-- road to ruin
  end
end


# Listing 2.6, pg. 25

class Gear
  attr_reader :chainring, :cog    # <-- hide instance variables behind encapsulating methods

  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def ratio
    chainring / cog.to_f    # <-- using attr_reader methods to access instance variables
  end
end


# Listing 2.7, pg. 25

# default-ish implementation via attr_reader
def cog
  @cog
end


# Listing 2.8, pg. 25

# a simple reimplementation of cog
def cog
  @cog * unanticipated_adjustment_factor
end


# Listing 2.9, pg. 26

# a more complex one
def cog
  @cog * (foo? ? bar_adjustment : baz_adjustment)
end


# Listing 2.10, pg. 26

class Gear
  private
  attr_reader :chainring, :cog

  public
  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end
  # ...
end

class Blinkered
  def cog(gear)
    gear.cog
  end
end

puts Blinkered.new.cog(Gear.new(54, 11))
#=> 1: from code-samples.rb:137:in `<main>'
#   code-samples.rb:133:in `cog': private method `cog' called for #<Gear:0x00007fe8df9df498 @chainring=54, @cog=11> (NoMethodError)


# Listing 2.11, pg. 27

class ObscuringReferences
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def diameters
    # 0 is rim, 1 is tire
    data.collect { |cell| cell[0] + (cell[1] * 2) }
  end
  # ...many other methods that index into the array
end


# Listing 2.12, pg. 27

# rim and tire sizes (now in millimeters!) in a 2d array
@data = [[622, 20], [622, 23], [559, 30], [559, 40]]


# Listing 2.13, pg. 28

class RevealingReferences
  attr_reader :wheels
  
  def initialize(data)
    @wheels = wheelify(data)
  end

  # now everyone can send rim/tire to wheel
  Wheel = Struct.new(:rim, :tire)
  def wheelify(data)
    data.collect { |cell| Wheel.new(cell[0], cell[1]) }
  end

  def diameters
    wheels.collect { |wheel| wheel.rim + (wheel.tire * 2) }
  end
end


# Listing 2.14, pg. 29

def diameters
  wheels.collect { |wheel| wheel.rim + (wheel.tire * 2) }
end


# Listing 2.15, pg. 30

# first - iterate over the array
def diameters
  wheels.collect { |wheel| diameter(wheel) }
end

# second - calculate diameter of ONE wheel
def diameter(wheel)
  wheel.rim + (wheel.tire * 2)
end


# Listing 2.16, pg. 30

def gear_inches
  # tire goes around rim twice for diameter
  ratio * (rim + (tire * 2))
end


# Listing 2.17, pg. 31

def gear_inches
  ratio * diameter
end

def diameter
  rim + (tire * 2)
end
