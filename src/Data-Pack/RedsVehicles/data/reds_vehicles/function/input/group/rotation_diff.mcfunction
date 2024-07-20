# This function gathers the rotation_diff input data
# It is run BY and AT the base vehicle entity

# Get player's rotation
execute store result score vehicle.yaw_diff vehicle.local on passengers if entity @s[tag=vehicle.pilot_seat] on passengers run data get entity @s Rotation[0] 10000
execute store result score vehicle.pitch_diff vehicle.local on passengers if entity @s[tag=vehicle.pilot_seat] on passengers run data get entity @s Rotation[1] 10000

# Compute difference
scoreboard players operation vehicle.yaw_diff vehicle.local -= @s vehicle.rot.yaw
scoreboard players operation vehicle.pitch_diff vehicle.local -= @s vehicle.rot.pitch

# Store result
execute store result storage reds_vehicles:inputs input.rotation_diff.yaw float 0.0001 run scoreboard players get vehicle.yaw_diff vehicle.local
execute store result storage reds_vehicles:inputs input.rotation_diff.pitch float 0.0001 run scoreboard players get vehicle.pitch_diff vehicle.local
