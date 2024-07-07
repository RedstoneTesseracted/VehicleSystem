# This function applies event-related configuration to the vehicle using
# arguments provided via function macros
#
# It is run BY the vehicle base entity

scoreboard players set @s vehicle.event.firework 0
scoreboard players set @s vehicle.event.honk 0
scoreboard players set @s vehicle.event.shoot 0
scoreboard players set @s vehicle.event.cooldown 0

$scoreboard players set @s vehicle.event.cooldown $(cooldown)
