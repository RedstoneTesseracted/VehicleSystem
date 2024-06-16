# This function checks if the current position is in an air block and returns the result

# Water and lava blocks not allowed
execute if function reds_vehicles:environment/water_check run return 0
execute if function reds_vehicles:environment/lava_check run return 0

# It's PROBABLY fine
return 1
