# This function handles configuring the vehicle base entity
# using various arguments provided via function macros
#
# It is called from reds_vehicles:summon/spawn, and is run 
# BY the newly spawned vehicle base entity

# Set basic NBT data
data merge entity @s {Invulnerable:1b,Invisible:1b,Small:1b}

# Assign tags
tag @s add vehicle.base
tag @s add vehicle.new
tag @s add vehicle.part
$tag @s add vehicle.name.$(name)

# Set entity name
data modify entity @s CustomName set from storage reds_vehicles:definitions summon.name

# Set attributes
$attribute @s minecraft:gravity base set $(base_gravity)
$attribute @s minecraft:scale base set $(scale)
$attribute @s minecraft:step_height base set $(step_height)

# Set up scoreboards
# Declare required scoreboards
scoreboard players set @s vehicle.rot.yaw 0
scoreboard players set @s vehicle.rot.pitch 0
scoreboard players set @s vehicle.rot.roll 0

scoreboard players set @s vehicle.dvel.x 0
scoreboard players set @s vehicle.dvel.y 0
scoreboard players set @s vehicle.dvel.z 0

scoreboard players set @s vehicle.accel.forward 0

scoreboard players set @s vehicle.engine 1

# Declare user-provided scores (if provided)
execute if data storage reds_vehicles:definitions summon.default_scores run function reds_vehicles:summon/set_default_scores

# Add elytra if elytra_glide force is present within physics list
# TODO: Change this to an invisible item with the glider tag in 1.21.2+
execute if data storage reds_vehicles:definitions summon.physics[{type:"elytra_glide"}] run item replace entity @s armor.chest with minecraft:elytra


# Configure events
#$function reds_vehicles:summon/configure_events $(events)

