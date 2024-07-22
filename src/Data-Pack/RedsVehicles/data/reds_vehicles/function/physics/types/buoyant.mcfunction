# This function handles application of the buoyant force

# Add an attribute modifier for the buoyant force
$attribute @s minecraft:generic.gravity modifier add reds_vehicles:buoyancy-$(uid) $(value) add_multiplied_base


# # This approach is based off a flawed understanding of how water impacts motion.
# # My guess is that being underwater creates a drag force that is applied BEFORE gravity
# # This complicates things, since we can't just counteract gravity anymore

# # Obtain the buoyancy constant times acceleration due to gravity at x100,000 fixed-point precision
# $execute store result storage reds_vehicles:physics temp.g double $(value) run attribute @s minecraft:generic.gravity base get 6250
# execute store result score vehicle.g vehicle.local run data get storage reds_vehicles:physics temp.g
# data remove storage reds_vehicles:physics temp.g

# # Add to velocity
# scoreboard players operation vehicle.vel.y vehicle.local += vehicle.g vehicle.local

#title @a actionbar {"score": {"name": "vehicle.vel.y","objective": "vehicle.local"}}

