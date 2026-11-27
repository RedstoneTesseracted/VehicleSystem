# This function applies special attribute modifiers to the player when mounting a vehicle.
# This assumed the player has already mounted the vehicle by this point.

# Retrieve the camera distance multiplier from the vehicle
data remove storage reds_vehicles:definitions args
execute on vehicle on vehicle run data modify storage reds_vehicles:definitions args.name set from entity @s CustomName
execute store result score vehicle.exists vehicle.local run function reds_vehicles:vehicle/grab_definition with storage reds_vehicles:definitions args
execute unless score vehicle.exists vehicle.local matches 1 run return fail

# Add attribute modifier
data remove storage reds_vehicles:definitions args
data modify storage reds_vehicles:definitions args.amount set from storage reds_vehicles:definitions current.camera_multiplier
function reds_vehicles:interact/__apply_attributes with storage reds_vehicles:definitions args

# Protect from fall damage
attribute @s minecraft:fall_damage_multiplier modifier remove reds_vehicles:fall_protection
attribute @s minecraft:fall_damage_multiplier modifier add reds_vehicles:fall_protection -1.0 add_multiplied_total
