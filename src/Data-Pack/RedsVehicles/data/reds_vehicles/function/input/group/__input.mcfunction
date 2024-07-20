# Function used by reds_vehicles:input/group/input to shift the execution to the pilot
# It is run BY and AT the pilot
#
# This function effectively applies a change-of-basis to the vector 𝗺:
# 
#   𝗺' = (𝗺•𝘂ˣᶻ)𝘂ˣᶻ+(𝗺•𝘄ˣᶻ)𝘄ˣᶻ
# 
# Where:
#     𝗺 = The player's motion vector in the xz-plane
#     𝗺' = The player's motion vector with respect to {𝘂ˣᶻ, 𝘄ˣᶻ}
#     𝘂ˣᶻ = The player's xz-plane look vector, given by -sin(θ)𝘅 + cos(θ)𝘇
#     𝘄ˣᶻ = The transverse xz-plane look vector, given by -cos(θ)𝘅 + sin(θ)𝘇
#     θ = The player's xz-rotation angle
#

# First, obtain the motion vector.  We assume a standard vector length of 57.21059149579407 and use x10,000 fixed-point
#execute store result storage reds_vehicles:inputs args.x float 0.0001 run data get entity @s Motion[0] 572105.9149579407
#execute store result storage reds_vehicles:inputs args.z float -0.0001 run data get entity @s Motion[2] 572105.9149579407
execute store result score vehicle.m.x vehicle.local run data get entity @s Motion[0] 572105.9149579407
execute store result score vehicle.m.z vehicle.local run data get entity @s Motion[2] 572105.9149579407


# Next, obtain the 𝘂ˣᶻ and 𝘄ˣᶻ vectors using x100 fixed-point
#execute store result score vehicle.p1.x vehicle.local run data get entity @s Pos[0] 100
#execute store result score vehicle.p1.z vehicle.local run data get entity @s Pos[2] 100
# Apparently it's faster grab data from a non-player entity?????
execute summon minecraft:marker run function reds_vehicles:input/group/xz_position_to_score {point: "p1"}

execute rotated ~ 0 positioned ^ ^ ^1 summon minecraft:marker run function reds_vehicles:input/group/xz_position_to_score {point: "p2"}
execute rotated ~-90 0 positioned ^ ^ ^1 summon minecraft:marker run function reds_vehicles:input/group/xz_position_to_score {point: "p3"}

scoreboard players operation vehicle.p2.x vehicle.local -= vehicle.p1.x vehicle.local
scoreboard players operation vehicle.p2.z vehicle.local -= vehicle.p1.z vehicle.local
scoreboard players operation vehicle.p3.x vehicle.local -= vehicle.p1.x vehicle.local
scoreboard players operation vehicle.p3.z vehicle.local -= vehicle.p1.z vehicle.local


# Finally, we compute the dot products 𝗺•𝘂ˣᶻ and 𝗺•𝘄ˣᶻ.  The multiplication brings us up to x1,000,000 fixed-point
scoreboard players operation vehicle.p2.x vehicle.local *= vehicle.m.x vehicle.local
scoreboard players operation vehicle.p2.z vehicle.local *= vehicle.m.z vehicle.local
scoreboard players operation vehicle.p2.x vehicle.local += vehicle.p2.z vehicle.local

scoreboard players operation vehicle.p3.x vehicle.local *= vehicle.m.x vehicle.local
scoreboard players operation vehicle.p3.z vehicle.local *= vehicle.m.z vehicle.local
scoreboard players operation vehicle.p3.x vehicle.local += vehicle.p3.z vehicle.local

# Send final result to storage
data modify storage reds_vehicles:inputs input.input set value {forward: 0, side: 0}
execute if score vehicle.p2.x vehicle.local matches 10000.. run data modify storage reds_vehicles:inputs input.input.forward set value 1
execute if score vehicle.p2.x vehicle.local matches ..-10000 run data modify storage reds_vehicles:inputs input.input.forward set value -1
execute if score vehicle.p3.x vehicle.local matches 10000.. run data modify storage reds_vehicles:inputs input.input.side set value 1
execute if score vehicle.p3.x vehicle.local matches ..-10000 run data modify storage reds_vehicles:inputs input.input.side set value -1


# Send final result to storage
#execute store result storage reds_vehicles:inputs input.input.forward float 0.000001 run scoreboard players get vehicle.p2.x vehicle.local
#execute store result storage reds_vehicles:inputs input.input.side float 0.000001 run scoreboard players get vehicle.p3.x vehicle.local
