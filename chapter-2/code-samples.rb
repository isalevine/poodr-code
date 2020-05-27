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

puts Gear.new(52, 11).ratio
#=> code-samples.rb:33:in `initialize': wrong number of arguments (given 2, expected 4) (ArgumentError)


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

class Gear
  def initialize(cog)
    @cog = cog
  end

  # default-ish implementation via attr_reader
  def cog
    @cog
  end
end