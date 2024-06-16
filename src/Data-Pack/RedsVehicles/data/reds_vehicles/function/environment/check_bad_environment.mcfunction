# This function checks whether the vehicle is in the correct environment and returns the result
# It is run BY and AT the base vehicle entity WHEN its vehicle.environment_type and vehicle.environment_penalty_type do not match zero

# Return 0 if not in correct environment, and 1 otherwise
execute if score @s vehicle.environment_type matches 1 if predicate reds_vehicles:environment/in_air run return 0
execute if score @s vehicle.environment_type matches 2 if predicate reds_vehicles:environment/in_water run return 0
execute if score @s vehicle.environment_type matches 3 if predicate reds_vehicles:environment/in_lava run return 0
return 1
