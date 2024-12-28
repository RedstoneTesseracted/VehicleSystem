# Function used by reds_vehicles:input/group/input to shift the execution to the pilot
# It is run BY and AT the pilot

# Obtain forward/side values using predicates
scoreboard players set vehicle.forward vehicle.local 0
scoreboard players set vehicle.side vehicle.local 0
execute if predicate reds_vehicles:input/forward run scoreboard players add vehicle.forward vehicle.local 1
execute if predicate reds_vehicles:input/backward run scoreboard players remove vehicle.forward vehicle.local 1
execute if predicate reds_vehicles:input/right run scoreboard players add vehicle.forward vehicle.local 1
execute if predicate reds_vehicles:input/left run scoreboard players remove vehicle.forward vehicle.local 1

# Send results to storage
data modify storage reds_vehicles:inputs input.input set value {forward: 0, side: 0}
execute store result storage reds_vehicles:inputs input.input.forward int 1 run scoreboard players get vehicle.forward vehicle.local
execute store result storage reds_vehicles:inputs input.input.side int 1 run scoreboard players get vehicle.side vehicle.local
