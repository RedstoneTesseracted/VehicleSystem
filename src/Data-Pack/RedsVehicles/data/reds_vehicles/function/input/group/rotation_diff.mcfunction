# This function gathers the rotation_diff input data
# It is run BY and AT the base vehicle entity

# Get player's rotation
execute store result score vehicle.yaw_diff vehicle.local on passengers if entity @s[tag=vehicle.pilot_seat] on passengers run data get entity @s Rotation[0] 10000
execute store result score vehicle.pitch_diff vehicle.local on passengers if entity @s[tag=vehicle.pilot_seat] on passengers run data get entity @s Rotation[1] 10000

# Compute difference
scoreboard players operation vehicle.yaw_diff vehicle.local -= @s vehicle.rot.yaw
scoreboard players operation vehicle.pitch_diff vehicle.local -= @s vehicle.rot.pitch

# Account for cases where the shortest rotation path crosses the ±180⁰ boundary
# execute if score @s vehicle.rot.yaw matches ..0 if score vehicle.yaw_diff vehicle.local matches 1800000.. run scoreboard players add vehicle.yaw_diff vehicle.local 3600000
# execute if score @s vehicle.rot.yaw matches 0.. if score vehicle.yaw_diff vehicle.local matches ..-1800000 run scoreboard players remove vehicle.yaw_diff vehicle.local 3600000
execute if score vehicle.yaw_diff vehicle.local matches 1800000.. run scoreboard players add vehicle.yaw_diff vehicle.local 3600000
execute if score vehicle.yaw_diff vehicle.local matches ..-1800000 run scoreboard players remove vehicle.yaw_diff vehicle.local 3600000

# Shouldn't occur for yaw since -90⁰ ≤ yaw ≤ 90⁰??


# Store result
execute store result storage reds_vehicles:inputs input.rotation_diff.yaw float 0.0001 run scoreboard players get vehicle.yaw_diff vehicle.local
execute store result storage reds_vehicles:inputs input.rotation_diff.pitch float 0.0001 run scoreboard players get vehicle.pitch_diff vehicle.local
