# This function checks if the current position is in a lava block and returns the result

# Matches generic lava tag
execute if block ~ ~ ~ #reds_vehicles:lava run return 1

# NOT in water
return 0
