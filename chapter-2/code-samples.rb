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
