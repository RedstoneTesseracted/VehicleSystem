# This function checks if the current position is in a water block and returns the result

# Matches generic water tag
execute if block ~ ~ ~ #reds_vehicles:water run return 1
# Waterlogged lights also count, but we have to check for those separately
execute if block ~ ~ ~ #reds_vehicles:water_when_waterlogged[waterlogged=true] run return 1

# NOT in water
return 0
