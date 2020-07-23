# Listing 8.10, pg. 173

class Parts < Array
  def spares
    select { |part| part.needs_spare }
  end
end


# Listing 8.11, pg. 174

# Parts inherits `+` from Array, so you can
# add two Parts together
combo_parts = (mountain_bike.parts + road_bike.parts)

puts mountain_bike.parts.class  #=>
puts road_bike.parts.class      #=>
puts combo_parts.class          #=>

# `+` definitely combines the Parts...
puts combo_parts.size           #=>

# ...but the object that `+` returns
# does not understand `spares`
puts combo_parts.spares         #=>
