# Function used by reds_vehicles:define/root/parse to process/validate the default_score list
# It uses a recursion-based loop to loop over the default_score list
# The actual recursive function is reds_vehicles:define/default_score_list/parse_loop
#
# If an error is raised during the loop, the loop will NOT immediately exit.
# Instead, the loop will finish to completion to allow any and all errors to be
# logged.  After that, this function will return with an error state
#
# The list in "working_default_score_list" under the "reds_vehicles:definitions"
# storage is ultimately modified in place assuming no errors occurred
#
# Returns a "0" on failure, and a "1" on success

# Set failure score
scoreboard players set vehicle.default_score_list_error vehicle.local 0

# Run loop
data modify storage reds_vehicles:definitions unprocessed_default_scores set from storage reds_vehicles:definitions working_default_score_list
data modify storage reds_vehicles:definitions processed_default_scores set value []
execute if data storage reds_vehicles:definitions unprocessed_default_scores[0] run function reds_vehicles:define/default_score_list/parse_loop
data modify storage reds_vehicles:definitions working_default_score_list set from storage reds_vehicles:definitions processed_default_scores

# Handle failure/success
execute if score vehicle.default_score_list_error vehicle.local matches 1 run return run function reds_vehicles:define/default_score_list/exit_fail
return run function reds_vehicles:define/default_score_list/exit_success
