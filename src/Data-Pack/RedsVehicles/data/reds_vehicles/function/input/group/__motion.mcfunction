# Function used by reds_vehicles:input/group/motion to shift the execution to the pilot

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

# Convert from the player's camera basis to the {x,z} basis and normalize
execute store result storage reds_vehicles:inputs args.forward int 1 run scoreboard players get vehicle.forward vehicle.local
execute store result storage reds_vehicles:inputs args.side int 1 run scoreboard players get vehicle.side vehicle.local
function reds_vehicles:input/group/__motion_macro with storage reds_vehicles:inputs args

