# This movement type causes the vehicle to instantly travel in the direction of the input vector

# Scale the speed by the thrust
scoreboard players operation @s vehicle.vel.x = @s vehicle.input.x
scoreboard players operation @s vehicle.vel.y = @s vehicle.input.y
scoreboard players operation @s vehicle.vel.z = @s vehicle.input.z

scoreboard players operation @s vehicle.vel.x *= @s vehicle.applied_thrust
scoreboard players operation @s vehicle.vel.y *= @s vehicle.applied_thrust
scoreboard players operation @s vehicle.vel.z *= @s vehicle.applied_thrust

# Make the motion directly controlled by the movement vector
execute store result entity @s Motion[0] double 0.000001 run scoreboard players get @s vehicle.vel.x
execute store result entity @s Motion[1] double 0.000001 run scoreboard players get @s vehicle.vel.y
execute store result entity @s Motion[2] double 0.000001 run scoreboard players get @s vehicle.vel.z
