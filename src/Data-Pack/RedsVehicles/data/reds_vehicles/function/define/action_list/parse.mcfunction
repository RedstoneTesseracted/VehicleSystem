# Function used by reds_vehicles:define/root/parse to process/validate the action list
# It uses a recursion-based loop to loop over the action list
# The actual recursive function is reds_vehicles:define/action_list/parse_loop
#
# If an error is raised during the loop, the loop will NOT immediately exit.
# Instead, the loop will finish to completion to allow any and all errors to be
# logged.  After that, this function will return with an error state
#
# The list in "working_action_list" under the "reds_vehicles:definitions"
# storage is ultimately modified in place assuming no errors occured
#
# Returns a "0" on failure, and a "1" on success

# Set failure score
scoreboard players set vehicle.action_list_error vehicle.local 0

# Run loop
data modify storage reds_vehicles:definitions unprocessed_actions set from storage reds_vehicles:definitions working_action_list
data modify storage reds_vehicles:definitions processed_actions set value []
execute if data storage reds_vehicles:definitions unprocessed_actions[0] run function reds_vehicles:define/action_list/parse_loop
data modify storage reds_vehicles:definitions working_action_list set from storage reds_vehicles:definitions processed_actions

# Handle failure/success
execute if score vehicle.action_list_error vehicle.local matches 1 run return run function reds_vehicles:define/action_list/exit_fail
return run function reds_vehicles:define/action_list/exit_success
