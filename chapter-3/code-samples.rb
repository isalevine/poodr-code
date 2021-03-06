# Listing 3.1 - pg. 38-39

class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter
  end

  def ratio
    chainring / cog.to_f
  end
  # ...
end

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter
    rim + (tire * 2)
  end
  # ...
end

puts Gear.new(52, 11, 26, 1.5).gear_inches
#=> 137.0909090909091


# Listing 3.2 - pg. 41-42

class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter
  end
  # ...
end

puts Gear.new(52, 11, 26, 1.5).gear_inches
#=> 137.0909090909091


# Listing 3.3, pg. 43

class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end

  def gear_inches
    ratio * wheel.diameter
  end
  # ...
end

# Gear expects a 'Duck' that knows 'diameter'
puts Gear.new(52, 11, Wheel.new(26, 1.5)).gear_inches
#=> 137.0909090909091


# Listing 3.4, pg. 44

class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @wheel = Wheel.new(rim, tire)
  end

  def gear_inches
    ratio * wheel.diameter
  end
  #...
end

puts Gear.new(52, 11, 26, 1.5).gear_inches
#=> 137.0909090909091


# Listing 3.5, pg. 45

class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def gear_inches
    ratio * wheel.diameter
  end

  def wheel
    @wheel ||= Wheel.new(rim, tire)
  end
  # ...
end

puts Gear.new(52, 11, 26, 1.5).gear_inches
#=> 137.0909090909091


# Listing 3.6, pg. 46

# `gear_inches` method below sends `ratio` and `wheel` to `self` 
# but sends `diameter` to `wheel`
def gear_inches
  ratio * wheel.diameter
end


# Listing 3.7, pg. 46

# imagine that calculating gear_inches required far more math
def gear_inches
  # ...
  # a 
  # few 
  # lines 
  # of 
  # scary 
  # math
  # ...
  foo = some_intermediate_result * wheel.diameter
  # ...
  # more 
  # lines 
  # of 
  # scary 
  # math
  # ...
end


# Listing 3.8, pg. 47

# removing the external dependency (Gear -> wheel, wheel -> diameter)
# and encapsulating it in a method of its own
def gear_inches
  # ...a few lines of scary math
  foo = some_intermediate_result * diameter
  # ...more lines of scary math
end

def diameter
  wheel.diameter
end


# Listing 3.9, pg. 48

class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end
  # ...
end

puts Gear.new(
  52,
  11,
  Wheel.new(26, 1.5)).gear_inches
#=> 137.0909090909091


# Listing 3.10, pg. 49

# using keyword arguments
class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring:, cog:, wheel:)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end
  # ...
end


# Listing 3.11, pg. 49

# pass keyword arguments as a hash
puts Gear.new(
  :cog => 11,
  :chainring => 52,
  :wheel => Wheel.new(26, 1.5)).gear_inches
#=> 137.0909090909091


# Listing 3.12, pg. 49

# using the explicit keyword syntax
puts Gear.new(
  wheel: Wheel.new(26, 1.5),
  chainring: 52,
  cog: 11).gear_inches
#=> 137.0909090909091


# Listing 3.13, pg. 50-51

class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring: 40, cog: 18, wheel:)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end
  # ...
end

puts Gear.new(wheel: Wheel.new(26, 1.5)).chainring
#=> 40


# Listing 3.14, pg. 51

class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring: default_chainring, cog: 18, wheel:)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end

  def default_chainring
    (100 / 2) - 10    # silly code, useful example
  end
  #...
end

puts Gear.new(wheel: Wheel.new(26, 1.5)).chainring
#=> 40

puts Gear.new(chainring: 52, wheel: Wheel.new(26, 1.5)).chainring
#=> 52


# Listing 3.15, pg. 52

# When Gear is part of an external interface
module SomeFramework
  class Gear
    attr_reader :chainring, :cog, :wheel
    
    def initialize(chainring, cog, wheel)
      @chainring = chainring
      @cog = cog
      @wheel = wheel
    end

    def gear_inches
      ratio * wheel.diameter
    end

    def ratio
      chainring / cog.to_f
    end
    # ...
  end
end

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter
    rim + (tire * 2)
  end
  # ...
end

# wrap the interface to protect yourself from changes
module GearWrapper
  def self.gear(chainring:, cog:, wheel:)
    SomeFramework::Gear.new(chainring, cog, wheel)
  end
end

# Now you can create a new Gear using keyword arguments
puts GearWrapper.gear(
  chainring: 52,
  cog: 11,
  wheel: Wheel.new(26, 1.5)).gear_inches
#=> 137.0909090909091


# Listing 3.16, pg. 54-55

class Gear
  attr_reader :chainring, :cog

  def initialize(chainring:, cog:)
    @chainring = chainring
    @cog = cog
  end

  def gear_inches(diameter)
    ratio * diameter
  end

  def ratio
    chainring / cog.to_f
  end
  # ...
end

class Wheel
  attr_reader :rim, :tire, :gear

  def initialize(rim:, tire:, chainring:, cog:)
    @rim = rim
    @tire = tire
    @gear = Gear.new(chainring: chainring, cog: cog)
  end

  def diameter
    rim + (tire * 2)
  end

  def gear_inches
    gear.gear_inches(diameter)
  end
  # ...
end

puts Wheel.new(
  rim: 26,
  tire: 1.5,
  chainring: 52,
  cog: 11).gear_inches
#=> 137.0909090909091
