# This function removes all gravity modifiers with the reds_vehicles: prefix\
#
# It is called from reds_vehicles:physics/reset_gravity
# It is run BY and AT the base vehicle entity

# Reset current modifier if it has the reds_vehicles namespace
data modify storage reds_vehicles:physics compare set value "reds_vehicles"
execute store success score vehicle.success vehicle.local run data modify storage reds_vehicles:physics compare set string storage reds_vehicles:physics modifiers 0 13
$execute if score vehicle.success vehicle.local matches 0 run attribute @s minecraft:gravity modifier remove $(id)

# Remove element and execute again if more elements remain
data remove storage reds_vehicles:physics modifiers[0]
execute if data storage reds_vehicles:physics modifiers[0] run function reds_vehicles:physics/reset_gravity_loop with storage reds_vehicles:physics modifiers[0]
