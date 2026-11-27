# This function runs whenever a player unmounts a vehicle.
# This is run BY and AT the player

tag @s remove vehicle.riding
attribute @s minecraft:camera_distance modifier remove reds_vehicles:fall_protection
attribute @s minecraft:camera_distance modifier remove reds_vehicles:camera_multiplier
