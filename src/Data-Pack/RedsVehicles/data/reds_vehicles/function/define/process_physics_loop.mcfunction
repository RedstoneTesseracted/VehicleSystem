# This function recursively parses entries in the vehicle's physics list
#
# Before running this function, the contents of "working.physics" are copied to "unprocessed_physics"
# This function then pops and processes the first element of "unprocessed_physics" before running again
#
# It is called from reds_vehicles:define/process_loop

scoreboard players set vehicle.asserted_local vehicle.local 0

# Pop the first element in the list
data modify storage reds_vehicles:definitions working_physics set from storage reds_vehicles:definitions unprocessed_physics[0]
data remove storage reds_vehicles:definitions unprocessed_physics[0]

# Run inner function that we can terminate upon failure
function reds_vehicles:define/process_physics_loop_inner

# Reset temporary scores
scoreboard players reset vehicle.environment_id vehicle.local
scoreboard players reset vehicle.physics_id vehicle.local
scoreboard players reset vehicle.asserted_local vehicle.local

# Run again if entries remain in the physics tag
execute if data storage reds_vehicles:definitions unprocessed_physics[0] run function reds_vehicles:define/process_physics_loop
