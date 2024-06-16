# This function is used to calculate the vehicle's acceleration vector
# This version is for both flying and submarine-like vehicles that have full XYZ motion
#
# It is run BY the vehicle seat entity WHEN a player is riding it

# Obtain player's look vector (x1,000 FP)
execute on passengers at @s run summon minecraft:marker ~ ~ ~ {Tags:["vehicle.p1"]}
execute on passengers at @s run summon minecraft:marker ^ ^ ^1 {Tags:["vehicle.p2"]}

execute store result score vehicle.p1.x vehicle.local run data get entity @e[tag=vehicle.p1,limit=1,type=minecraft:marker] Pos[0] 1000.0
execute store result score vehicle.p1.y vehicle.local run data get entity @e[tag=vehicle.p1,limit=1,type=minecraft:marker] Pos[1] 1000.0
execute store result score vehicle.p1.z vehicle.local run data get entity @e[tag=vehicle.p1,limit=1,type=minecraft:marker] Pos[2] 1000.0

execute store result score vehicle.p2.x vehicle.local run data get entity @e[tag=vehicle.p2,limit=1,type=minecraft:marker] Pos[0] 1000.0
execute store result score vehicle.p2.y vehicle.local run data get entity @e[tag=vehicle.p2,limit=1,type=minecraft:marker] Pos[1] 1000.0
execute store result score vehicle.p2.z vehicle.local run data get entity @e[tag=vehicle.p2,limit=1,type=minecraft:marker] Pos[2] 1000.0

scoreboard players operation vehicle.p2.x vehicle.local -= vehicle.p1.x vehicle.local
scoreboard players operation vehicle.p2.y vehicle.local -= vehicle.p1.y vehicle.local
scoreboard players operation vehicle.p2.z vehicle.local -= vehicle.p1.z vehicle.local

# Upgrade to expected x100,000 precision expected elsewhere
scoreboard players operation vehicle.p2.x vehicle.local *= 100 vehicle.constants
scoreboard players operation vehicle.p2.y vehicle.local *= 100 vehicle.constants
scoreboard players operation vehicle.p2.z vehicle.local *= 100 vehicle.constants

# Pass along to input vector
scoreboard players operation vehicle.input.x vehicle.local = vehicle.p2.x vehicle.local
scoreboard players operation vehicle.input.y vehicle.local = vehicle.p2.y vehicle.local
scoreboard players operation vehicle.input.z vehicle.local = vehicle.p2.z vehicle.local

# Remove temporary marker entities
kill @e[tag=vehicle.p1,type=minecraft:marker]
kill @e[tag=vehicle.p2,type=minecraft:marker]
