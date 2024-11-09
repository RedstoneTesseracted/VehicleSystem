# Changes the current velocity in the direction the vehicle base 
# entity is pointing using the following score:
#   vehicle.accel.forward
# 
# Said scores are reset to zero afterwards
#
# This function is called from reds_vehicles:physics/apply

# Apply scale factor to forward acceleration score
$execute store result storage reds_vehicles:physics temp.a double $(value) run scoreboard players get @s vehicle.accel.forward
execute store result storage reds_vehicles:physics temp.a double 0.001 run data get storage reds_vehicles:physics temp.a

# Prepare current velocity for use in function macro
execute store result storage reds_vehicles:physics temp.vx double 0.00001 run scoreboard players get vehicle.vel.x vehicle.local
execute store result storage reds_vehicles:physics temp.vy double 0.00001 run scoreboard players get vehicle.vel.y vehicle.local
execute store result storage reds_vehicles:physics temp.vz double 0.00001 run scoreboard players get vehicle.vel.z vehicle.local

# Perform some *vector addition* (woah) (Minecraft ain't ready for this)
# We position this at (0.0 0.0 0.0) at use tilde-offset in the function to work around 
# the fact that (0 0 0) gets interpreted as (0.5 0.5 0.5).
# This becomes relevant when the velocity is zero.
execute positioned 0.0 0.0 0.0 run function reds_vehicles:physics/utility/accel_forward_helper with storage reds_vehicles:physics temp

execute store result score vehicle.vel.x vehicle.local run data get storage reds_vehicles:physics temp.x 100000
execute store result score vehicle.vel.y vehicle.local run data get storage reds_vehicles:physics temp.y 100000
execute store result score vehicle.vel.z vehicle.local run data get storage reds_vehicles:physics temp.z 100000


# # Get vector in direction vehicle base entity is facing
# execute store result score vehicle.p1.x vehicle.local run data get entity @s Pos[0] 100
# execute store result score vehicle.p1.y vehicle.local run data get entity @s Pos[1] 100
# execute store result score vehicle.p1.z vehicle.local run data get entity @s Pos[2] 100

# execute positioned ^ ^ ^1 summon minecraft:marker run function reds_vehicles:physics/p2_to_score

# scoreboard players operation vehicle.p2.x vehicle.local -= vehicle.p1.x vehicle.local
# scoreboard players operation vehicle.p2.y vehicle.local -= vehicle.p1.y vehicle.local
# scoreboard players operation vehicle.p2.z vehicle.local -= vehicle.p1.z vehicle.local

# # Apply scale factor to score
# $execute store result storage reds_vehicles:physics temp.u double $(value) run scoreboard players get @s vehicle.accel.forward
# execute store result score vehicle.accel.forward vehicle.local run data get storage reds_vehicles:physics temp.u
# data remove storage reds_vehicles:physics temp

# # Multiply by magnitude and correct precision
# #   vehicle.p2.x          - x100 fixed-point
# #   vehicle.accel.forward - x1000 fixed-point
# #   vehicle.vel.x         - x100000 fixed-point
# scoreboard players operation vehicle.p2.x vehicle.local *= vehicle.accel.forward vehicle.local
# scoreboard players operation vehicle.p2.y vehicle.local *= vehicle.accel.forward vehicle.local
# scoreboard players operation vehicle.p2.z vehicle.local *= vehicle.accel.forward vehicle.local

# # Add to current velocity vector
# scoreboard players operation vehicle.vel.x vehicle.local += vehicle.p2.x vehicle.local
# scoreboard players operation vehicle.vel.y vehicle.local += vehicle.p2.y vehicle.local
# scoreboard players operation vehicle.vel.z vehicle.local += vehicle.p2.z vehicle.local

# Reset scores if enabled
execute unless predicate reds_vehicles:utility/unapplied_force_no_reset run scoreboard players set @s vehicle.accel.forward 0
