# This function grants the player a camera distance attribute modifier when mounting a vehicle
# This assumed the player has mounted the vehicle

# Retrieve the camera distance multiplier from the vehicle
data remove storage reds_vehicles:definitions args
execute on vehicle on vehicle run data modify storage reds_vehicles:definitions args.name set from entity @s CustomName
execute store result score vehicle.exists vehicle.local run function reds_vehicles:vehicle/grab_definition with storage reds_vehicles:definitions args
execute unless score vehicle.exists vehicle.local matches 1 run return fail

# Add attribute modifier
data remove storage reds_vehicles:definitions args
data modify storage reds_vehicles:definitions args.amount set from storage reds_vehicles:definitions current.camera_multiplier
function reds_vehicles:interact/__apply_camera_multiplier with storage reds_vehicles:definitions args
