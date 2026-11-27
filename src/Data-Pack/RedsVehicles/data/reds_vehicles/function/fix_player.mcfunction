# This function contains several fixes for player states that *shouldn't* occur
# We do this out of an abundance of caution
# It is run BY the player

# Reset score-based triggers
scoreboard players reset @s vehicle.showlog
scoreboard players enable @s vehicle.showlog
scoreboard players reset @s vehicle.listvehicles
scoreboard players enable @s vehicle.listvehicles

# Reset advancement-based triggers
advancement revoke @s from reds_vehicles:hidden/trigger_root

# Clear temporary attribute modifiers
execute unless function reds_vehicles:vehicle/is_riding_vehicle run attribute @s minecraft:camera_distance modifier remove reds_vehicles:fall_protection
execute unless function reds_vehicles:vehicle/is_riding_vehicle run attribute @s minecraft:camera_distance modifier remove reds_vehicles:camera_multiplier
