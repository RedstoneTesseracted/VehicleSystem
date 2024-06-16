# This movement type causes the vehicle to accelerate in the direction of the input vector, but applies a lift force [NOT YET IMPLEMENTED]

# Apply the thrust multiplier and shift decimal point to keep us at the same fixed-point precision
scoreboard players operation @s vehicle.input.x *= @s vehicle.applied_thrust
scoreboard players operation @s vehicle.input.y *= @s vehicle.applied_thrust
scoreboard players operation @s vehicle.input.z *= @s vehicle.applied_thrust

scoreboard players operation @s vehicle.input.x /= 100 vehicle.constants
scoreboard players operation @s vehicle.input.y /= 100 vehicle.constants
scoreboard players operation @s vehicle.input.z /= 100 vehicle.constants

# Add to current motion
execute store result score vehicle.vel.x vehicle.local run data get entity @s Motion[0] 100000
execute store result score vehicle.vel.y vehicle.local run data get entity @s Motion[1] 100000
execute store result score vehicle.vel.z vehicle.local run data get entity @s Motion[2] 100000

scoreboard players operation vehicle.vel.x vehicle.local += @s vehicle.input.x
scoreboard players operation vehicle.vel.y vehicle.local += @s vehicle.input.y
scoreboard players operation vehicle.vel.z vehicle.local += @s vehicle.input.z

# Apply the new motion
execute store result entity @s Motion[0] double 0.00001 run scoreboard players get vehicle.vel.x vehicle.local
execute store result entity @s Motion[1] double 0.00001 run scoreboard players get vehicle.vel.y vehicle.local
execute store result entity @s Motion[2] double 0.00001 run scoreboard players get vehicle.vel.z vehicle.local

# Apply the new motion
execute store result entity @s Motion[0] double 0.0000095 run scoreboard players get vehicle.vel.x vehicle.local
execute store result entity @s Motion[1] double 0.0000095 run scoreboard players get vehicle.vel.y vehicle.local
execute store result entity @s Motion[2] double 0.0000095 run scoreboard players get vehicle.vel.z vehicle.local

