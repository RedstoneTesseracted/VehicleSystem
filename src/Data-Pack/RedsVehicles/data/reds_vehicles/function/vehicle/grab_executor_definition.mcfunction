# Obtains the vehicle definition for entity that executed this function.
# This function should be run only by the root vehicle entity
#
# Returns:
#   0 if no matching vehicle definition could be found
#   1 if a definition exists for this vehicle

data remove storage reds_vehicles:definitions args
data modify storage reds_vehicles:definitions args.name set from entity @s CustomName
execute store result score vehicle.exists vehicle.local run function reds_vehicles:vehicle/grab_definition with storage reds_vehicles:definitions args
execute unless score vehicle.exists vehicle.local matches 1 run return 0
return 1
