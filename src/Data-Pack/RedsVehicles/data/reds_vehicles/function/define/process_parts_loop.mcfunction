# This function recursively parses entries in the vehicle's parts list
#
# Before running this function, the contents of "working.parts" are copied to "unprocessed_parts"
# This function then pops and processes the first element of "unprocessed_parts" before running again
#
# It is called from reds_vehicles:define/process_loop

scoreboard players set vehicle.asserted_local vehicle.local 0

# Pop the first element in the list
data modify storage reds_vehicles:definitions working_part set from storage reds_vehicles:definitions unprocessed_parts[0]
data remove storage reds_vehicles:definitions unprocessed_parts[0]

# Run inner function that we can terminate upon failure
function reds_vehicles:define/process_parts_loop_inner

# Remove temporary NBT data
data remove storage reds_vehicles:definitions working_entity

# Reset temporary scores
scoreboard players reset vehicle.transform_array_length vehicle.local
scoreboard players reset vehicle.asserted_local vehicle.local

# Run again if entries remain in the parts tag
execute if data storage reds_vehicles:definitions unprocessed_parts[0] run function reds_vehicles:define/process_parts_loop

