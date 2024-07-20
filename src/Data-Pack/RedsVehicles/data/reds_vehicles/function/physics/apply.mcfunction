# This function handles the application of physics forces
# and updates motion-related data
#
# It is called from reds_vehicles:vehicle/root
# It is run BY and AT the base vehicle entity


# Obtain current velocity (x100000 fixed-point)
execute store result score vehicle.vel.x vehicle.local run data get entity @s Motion[0] 100000
execute store result score vehicle.vel.y vehicle.local run data get entity @s Motion[1] 100000
execute store result score vehicle.vel.z vehicle.local run data get entity @s Motion[2] 100000


# Handle applied force
# Via vehicle.dvel.*
execute if predicate reds_vehicles:nonzero_dvel run function reds_vehicles:physics/dvel
# Via vehicle.accel.forward
execute unless score @s vehicle.accel.forward matches 0 run function reds_vehicles:physics/accel_forward



# Set base rotation to match scores
execute store result entity @s Rotation[0] float 0.0001 run scoreboard players get @s vehicle.rot.yaw
execute store result entity @s Rotation[1] float 0.0001 run scoreboard players get @s vehicle.rot.pitch


# Apply additional forces
execute if data storage reds_vehicles:definitions current.physics[0] run function reds_vehicles:physics/apply_loop


# Set new velocity
execute store result entity @s Motion[0] double 0.00001 run scoreboard players get vehicle.vel.x vehicle.local
execute store result entity @s Motion[1] double 0.00001 run scoreboard players get vehicle.vel.y vehicle.local
execute store result entity @s Motion[2] double 0.00001 run scoreboard players get vehicle.vel.z vehicle.local


