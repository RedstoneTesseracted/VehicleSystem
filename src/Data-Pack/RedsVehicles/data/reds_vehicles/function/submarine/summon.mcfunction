# This function summons a new submarine vehicle assembly
# Three entities are required:
# 	1) Base armor stand (no gravity, scaled down, invisible)
#   2) Item display model (transformed larger, riding armor stand)
#   3) Interaction entity (right-click to mount, riding armor stand)
#

# Summon base
summon minecraft:armor_stand ~ ~ ~ {attributes:[{base:0.0d,id:"minecraft:generic.gravity"},{base:0.05d,id:"minecraft:generic.scale"}],Tags:["vehicle.submarine","vehicle.base","vehicle.new_base"],Small:1b,Invisible:1b}

# Summon and mount display
summon minecraft:item_display ~ ~ ~ {Tags:["vehicle.submarine","vehicle.model","vehicle.new_model"],transformation:[4.0f,0.0f,0.0f,-2.0f,0.0f,4.0f,0.0f,-2.0f,0.0f,0.0f,4.0f,-2.0f,0.0f,0.0f,0.0f,1.0f],item:{id:"minecraft:glass"}}
item replace entity @e[tag=vehicle.new_model,limit=1] container.0 with minecraft:glass[minecraft:custom_model_data=1414716]
ride @e[tag=vehicle.new_model,limit=1] mount @e[tag=vehicle.new_base,limit=1]

# Summon and mount seat
summon minecraft:interaction ~ ~ ~ {Tags:["vehicle.submarine","vehicle.seat","vehicle.new_seat"],response:1b,width:4.0f,height:2.0f}
ride @e[tag=vehicle.new_seat,limit=1] mount @e[tag=vehicle.new_base,limit=1]

# Set scoreboard values
# Control type: Full 3D (1)
# Physics type: Accelerate in direction of input (1)
# Environment type: Underwater (0)
# Incorrect environment penalty type: Slowed thrust, sinking (1)
# Set control type to full 3D
scoreboard players set @e[tag=vehicle.new_base] vehicle.control_type 1
scoreboard players set @e[tag=vehicle.new_base] vehicle.physics_type 1
scoreboard players set @e[tag=vehicle.new_base] vehicle.environment_type 2
scoreboard players set @e[tag=vehicle.new_base] vehicle.environment_penalty_type 1

# Movement attributes
scoreboard players set @e[tag=vehicle.new_base] vehicle.max_thrust 10
execute as @e[tag=vehicle.new_base] run scoreboard players operation @s vehicle.applied_thrust = @s vehicle.max_thrust


# Motion variables
scoreboard players set @e[tag=vehicle.new_base] vehicle.input.x 0
scoreboard players set @e[tag=vehicle.new_base] vehicle.input.y 0
scoreboard players set @e[tag=vehicle.new_base] vehicle.input.z 0

scoreboard players set @e[tag=vehicle.new_base] vehicle.acc.x 0
scoreboard players set @e[tag=vehicle.new_base] vehicle.acc.y 0
scoreboard players set @e[tag=vehicle.new_base] vehicle.acc.z 0

scoreboard players set @e[tag=vehicle.new_base] vehicle.vel.x 0
scoreboard players set @e[tag=vehicle.new_base] vehicle.vel.y 0
scoreboard players set @e[tag=vehicle.new_base] vehicle.vel.z 0


# Clear "new" tags
tag @e[tag=vehicle.new_base] remove vehicle.new_base
tag @e[tag=vehicle.new_model] remove vehicle.new_model
tag @e[tag=vehicle.new_seat] remove vehicle.new_seat

