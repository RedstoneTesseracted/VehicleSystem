# Changes the current velocity in the direction the vehicle base 
# entity is pointing using the following score:
#   vehicle.accel.forward
# 
# Said scores are reset to zero afterwards
#
# This function is called from reds_vehicles:physics/apply

# Get vector in direction vehicle base entity is facing
execute store result score vehicle.p1.x vehicle.local run data get entity @s Pos[0] 100
execute store result score vehicle.p1.y vehicle.local run data get entity @s Pos[1] 100
execute store result score vehicle.p1.z vehicle.local run data get entity @s Pos[2] 100

execute positioned ^ ^ ^1 summon minecraft:marker run function reds_vehicles:physics/p2_to_score

scoreboard players operation vehicle.p2.x vehicle.local -= vehicle.p1.x vehicle.local
scoreboard players operation vehicle.p2.y vehicle.local -= vehicle.p1.y vehicle.local
scoreboard players operation vehicle.p2.z vehicle.local -= vehicle.p1.z vehicle.local

# Apply scale factor to score
$execute store result storage reds_vehicles:physics temp.u double $(value) run scoreboard players get @s vehicle.accel.forward
execute store result score @s vehicle.accel.forward run data get storage reds_vehicles:physics temp.u
data remove storage reds_vehicles:physics temp

# Multiply by magnitude and correct precision
#   vehicle.p2.x          - x100 fixed-point
#   vehicle.accel.forward - x1000 fixed-point
#   vehicle.vel.x         - x100000 fixed-point
scoreboard players operation vehicle.p2.x vehicle.local *= @s vehicle.accel.forward
scoreboard players operation vehicle.p2.y vehicle.local *= @s vehicle.accel.forward
scoreboard players operation vehicle.p2.z vehicle.local *= @s vehicle.accel.forward

# Add to current velocity vector
scoreboard players operation vehicle.vel.x vehicle.local += vehicle.p2.x vehicle.local
scoreboard players operation vehicle.vel.y vehicle.local += vehicle.p2.y vehicle.local
scoreboard players operation vehicle.vel.z vehicle.local += vehicle.p2.z vehicle.local

# Reset scores
scoreboard players set @s vehicle.accel.forward 0
