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
$attribute @s minecraft:generic.gravity base set $(base_gravity)
$attribute @s minecraft:generic.scale base set $(scale)

# Set up scoreboards
scoreboard players set @s vehicle.rot.yaw 0
scoreboard players set @s vehicle.rot.pitch 0
scoreboard players set @s vehicle.rot.roll 0

scoreboard players set @s vehicle.vel.x 0
scoreboard players set @s vehicle.vel.y 0
scoreboard players set @s vehicle.vel.z 0

scoreboard players set @s vehicle.accel.forward 0

scoreboard players set @s vehicle.engine 1

# Configure events
#$function reds_vehicles:summon/configure_events $(events)

