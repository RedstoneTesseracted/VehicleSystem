# Function used by reds_vehicles:input/group/motion to shift the execution to the pilot
# Forward/side motion is collected by the "input" input type

# Abort early if not moving
execute if data storage reds_vehicles:inputs input.input{forward: 0, side: 0} run data modify storage reds_vehicles:inputs input.motion set value {x: 0.0f, z: 0.0f}
execute if data storage reds_vehicles:inputs input.input{forward: 0, side: 0} run return 1

# Convert from the player's camera basis to the {x,z} basis and normalize
function reds_vehicles:input/group/__motion_macro with storage reds_vehicles:inputs input.input

