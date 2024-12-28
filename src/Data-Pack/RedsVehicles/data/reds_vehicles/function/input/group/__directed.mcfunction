# Function used by reds_vehicles:input/group/directed to shift the execution to the pilot
# It is run BY and AT the pilot
#
# This function effectively computes the vector:
# 
#   𝗺' = (𝗺•𝘂ˣᶻ)𝘂+(𝗺•𝘄ˣᶻ)𝘄
# 
# Where:
#     𝗺 = The player's motion vector in the xz-plane
#     𝘂ˣᶻ = The player's xz-plane look vector, given by -sin(θ)𝘅 + cos(θ)𝘇
#     𝘄ˣᶻ = The transverse xz-plane look vector, given by -cos(θ)𝘅 + sin(θ)𝘇
#     𝘂 = The player's look vector, given by -sin(θ)cos(φ)𝘅 - sin(φ)𝘆 + cos(θ)cos(φ)𝘇
#     𝘄 = The transverse look vector, given by -cos(θ)𝘅 + sin(θ)𝘇
#     θ = The player's xz-rotation angle
#


# Obtain forward/side values using predicates
scoreboard players set vehicle.forward vehicle.local 0
scoreboard players set vehicle.side vehicle.local 0
execute if predicate reds_vehicles:input/forward run scoreboard players add vehicle.forward vehicle.local 1
execute if predicate reds_vehicles:input/backward run scoreboard players remove vehicle.forward vehicle.local 1
execute if predicate reds_vehicles:input/right run scoreboard players add vehicle.side vehicle.local 1
execute if predicate reds_vehicles:input/left run scoreboard players remove vehicle.side vehicle.local 1

# Abort early if not moving
execute if score vehicle.forward vehicle.local matches 0 if score vehicle.side vehicle.local matches 0 run data modify storage reds_vehicles:inputs input.directed set value {x: 0.0f, y: 0.0f, z: 0.0f}
execute if score vehicle.forward vehicle.local matches 0 if score vehicle.side vehicle.local matches 0 run return 1

# Convert from the player's camera basis to the {x,y,z} basis and normalize
execute store result storage reds_vehicles:inputs args.forward int 1 run scoreboard players get vehicle.forward vehicle.local
execute store result storage reds_vehicles:inputs args.side int 1 run scoreboard players get vehicle.side vehicle.local
function reds_vehicles:input/group/__directed_macro with storage reds_vehicles:inputs args
