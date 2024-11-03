# Function used by reds_vehicles:define/root/parse to process/validate the handling list
# It uses a recursion-based loop to loop over the handling list
# The actual recursive function is reds_vehicles:define/handling_list/parse_loop
#
# If an error is raised during the loop, the loop will NOT immediately exit.
# Instead, the loop will finish to completion to allow any and all errors to be
# logged.  After that, this function will return with an error state
#
# The list in "working_handling_list" under the "reds_vehicles:definitions"
# storage is ultimately modified in place assuming no errors occurred
#
# Additionally, a list of strings containing all used input groups is generated 
# at "working_input_list" under "reds_vehicles:definitions"
#
# Returns a "0" on failure, and a "1" on success

# Set failure score
scoreboard players set vehicle.handling_list_error vehicle.local 0

# Run loop
data modify storage reds_vehicles:definitions unprocessed_handling set from storage reds_vehicles:definitions working_handling_list
data modify storage reds_vehicles:definitions processed_handling set value []
execute if data storage reds_vehicles:definitions unprocessed_handling[0] run function reds_vehicles:define/handling_list/parse_loop
data modify storage reds_vehicles:definitions working_handling_list set from storage reds_vehicles:definitions processed_handling

# Handle failure/success
execute if score vehicle.handling_list_error vehicle.local matches 1 run return run function reds_vehicles:define/handling_list/exit_fail
return run function reds_vehicles:define/handling_list/exit_success
