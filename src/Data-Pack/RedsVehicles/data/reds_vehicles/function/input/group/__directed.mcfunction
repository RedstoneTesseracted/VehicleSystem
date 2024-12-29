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
# Forward/side motion is collected by the "input" input type

# Abort early if not moving
execute if data storage reds_vehicles:inputs input.input{forward: 0, side: 0} run data modify storage reds_vehicles:inputs input.directed set value {x: 0.0f, y: 0.0f, z: 0.0f}
execute if data storage reds_vehicles:inputs input.input{forward: 0, side: 0} run return 1

# Convert from the player's camera basis to the {x,y,z} basis and normalize
function reds_vehicles:input/group/__directed_macro with storage reds_vehicles:inputs input.input
