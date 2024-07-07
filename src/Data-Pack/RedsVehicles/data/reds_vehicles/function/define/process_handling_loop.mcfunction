# This function recursively parses/validates entries in the working vehicle's handling list
#
# Before running this function, the contents of "working.handling" are copied to "unprocessed_handling"
# This function then pops and processes the first element of "unprocessed_handling" before running again
#
# It is called from reds_vehicles:define/process_loop

scoreboard players set vehicle.asserted_local vehicle.local 0

# Pop the first element in the list
data modify storage reds_vehicles:definitions working_handling set from storage reds_vehicles:definitions unprocessed_handling[0]
data remove storage reds_vehicles:definitions unprocessed_handling[0]

# Run the inner part of the loop
execute store success score vehicle.success vehicle.local run function reds_vehicles:define/process_handling_loop_inner
execute if score vehicle.success vehicle.local matches 0 run scoreboard players set vehicle.error vehicle.local 1

# Reset temporary scores
scoreboard players reset vehicle.asserted_local vehicle.local


# Run again if entries remain in the handling tag
execute if data storage reds_vehicles:definitions unprocessed_handling[0] run function reds_vehicles:define/process_handling_loop
