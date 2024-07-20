# This function helps to convert the current position into a score
# It is intended to be run using `/execute summon`, and will automatically 
# destroy the summoned marker entity

# Get position and store in scoreboard
execute store result score vehicle.p2.x vehicle.local run data get entity @s Pos[0] 100
execute store result score vehicle.p2.y vehicle.local run data get entity @s Pos[1] 100
execute store result score vehicle.p2.z vehicle.local run data get entity @s Pos[2] 100

# Destroy the summoned marker entity
kill @s[type=minecraft:marker]

