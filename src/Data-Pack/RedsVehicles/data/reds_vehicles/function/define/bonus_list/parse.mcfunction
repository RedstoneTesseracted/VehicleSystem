# Function used by reds_vehicles:define/root/parse to process/validate the bonus list
# It uses a recursion-based loop to loop over the bonus list
# The actual recursive function is reds_vehicles:define/bonus_list/parse_loop
#
# If an error is raised during the loop, the loop will NOT immediately exit.
# Instead, the loop will finish to completion to allow any and all errors to be
# logged.  After that, this function will return with an error state
#
# The list in "working_bonus_list" under the "reds_vehicles:definitions"
# storage is ultimately modified in place assuming no errors occured
#
# Returns a "0" on failure, and a "1" on success

# Set failure score
scoreboard players set vehicle.bonus_list_error vehicle.local 0

# Run loop
data modify storage reds_vehicles:definitions unprocessed_bonuses set from storage reds_vehicles:definitions working_bonus_list
data modify storage reds_vehicles:definitions processed_bonuses set value []
execute if data storage reds_vehicles:definitions unprocessed_bonuses[0] run function reds_vehicles:define/bonus_list/parse_loop
data modify storage reds_vehicles:definitions working_bonus_list set from storage reds_vehicles:definitions processed_bonuses

# Handle failure/success
execute if score vehicle.bonus_list_error vehicle.local matches 1 run return run function reds_vehicles:define/bonus_list/exit_fail
return run function reds_vehicles:define/bonus_list/exit_success
