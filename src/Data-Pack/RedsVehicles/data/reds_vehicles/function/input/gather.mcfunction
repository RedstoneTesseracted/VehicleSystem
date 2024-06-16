# Root function used to calculate the vehicle's acceleration vector
# This will either branch to 2D or 3D motion based on the vehicle's control type
#
# It is run BY the vehicle base WHEN a player is riding the vehicle

# Obtain acceleration vector using one of two methods
execute if score @s vehicle.control_type matches 1 on passengers if entity @s[tag=vehicle.seat,type=minecraft:interaction] run function reds_vehicles:input/gather_3d
execute if score @s vehicle.control_type matches 2 on passengers if entity @s[tag=vehicle.seat,type=minecraft:interaction] run function reds_vehicles:input/gather_2d
execute if score @s vehicle.control_type matches 3 on passengers if entity @s[tag=vehicle.seat,type=minecraft:interaction] run function reds_vehicles:input/gather_look_3d
execute if score @s vehicle.control_type matches 4 on passengers if entity @s[tag=vehicle.seat,type=minecraft:interaction] run function reds_vehicles:input/gather_look_2d

# Store acceleration vector in base
scoreboard players operation @s vehicle.input.x = vehicle.input.x vehicle.local
scoreboard players operation @s vehicle.input.y = vehicle.input.y vehicle.local
scoreboard players operation @s vehicle.input.z = vehicle.input.z vehicle.local

# Debug code
# execute store result storage vehicle:utility args.x float 0.000001 run scoreboard players get @s vehicle.input.x
# execute store result storage vehicle:utility args.y float 0.000001 run scoreboard players get @s vehicle.input.y
# execute store result storage vehicle:utility args.z float 0.000001 run scoreboard players get @s vehicle.input.z
# function reds_vehicles:_test with storage vehicle:utility args
