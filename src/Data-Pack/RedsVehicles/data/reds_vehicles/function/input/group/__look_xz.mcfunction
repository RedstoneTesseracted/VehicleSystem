# Function used by reds_vehicles:input/group/look to shift the execution to the pilot
# It is run BY and AT the pilot

# Get first and second positions
execute store result score vehicle.p1.x vehicle.local run data get entity @s Pos[0] 100
execute store result score vehicle.p1.z vehicle.local run data get entity @s Pos[2] 100
execute rotated ~ 0.0 positioned ^ ^ ^1 summon minecraft:marker run function reds_vehicles:input/group/xz_position_to_score {point: "p2"}

# Compute difference to obtain vector
scoreboard players operation vehicle.p2.x vehicle.local -= vehicle.p1.x vehicle.local
scoreboard players operation vehicle.p2.z vehicle.local -= vehicle.p1.z vehicle.local

# Store result
execute store result storage reds_vehicles:inputs input.look_xz.x float 0.001 run scoreboard players get vehicle.p2.x vehicle.local
execute store result storage reds_vehicles:inputs input.look_xz.z float 0.001 run scoreboard players get vehicle.p2.z vehicle.local
