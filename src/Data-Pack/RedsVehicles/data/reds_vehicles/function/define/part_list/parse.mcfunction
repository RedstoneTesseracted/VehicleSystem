# Function used by reds_vehicles:define/root/parse to process/validate the part list
# It uses a recursion-based loop to loop over the part list
# The actual recursive function is reds_vehicles:define/part_list/parse_loop
#
# If an error is raised during the loop, the loop will NOT immediately exit.
# Instead, the loop will finish to completion to allow any and all errors to be
# logged.  After that, this function will return with an error state
#
# The list in "working_part_list" under the "reds_vehicles:definitions"
# storage is ultimately modified in place assuming no errors occured
#
# part entries with the "gravity" type will be omitted from the final 
# list.  Instead the last one's "value" field will be written to 
# "reds_vehicles:definitions.working_base_gravity
#
# Returns a "0" on failure, and a "1" on success

# Set failure score
scoreboard players set vehicle.part_list_error vehicle.local 0

# Run loop
data modify storage reds_vehicles:definitions unprocessed_parts set from storage reds_vehicles:definitions working_part_list
data modify storage reds_vehicles:definitions processed_parts set value []
execute if data storage reds_vehicles:definitions unprocessed_parts[0] run function reds_vehicles:define/part_list/parse_loop
data modify storage reds_vehicles:definitions working_part_list set from storage reds_vehicles:definitions processed_parts

# Handle failure/success
execute if score vehicle.part_list_error vehicle.local matches 1 run return run function reds_vehicles:define/part_list/exit_fail
return run function reds_vehicles:define/part_list/exit_success
