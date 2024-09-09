# This function handles the looping aspect of reds_vehicles:define/action_list/parse
#
# Does NOT return a success/failure code

# Pop the first element in the list
data modify storage reds_vehicles:definitions working_action set from storage reds_vehicles:definitions unprocessed_actions[0]
data remove storage reds_vehicles:definitions unprocessed_actions[0]

# Process actions element
execute unless function reds_vehicles:define/action/parse run scoreboard players set vehicle.action_list_error vehicle.local 1

# Add processed element to processed array
data modify storage reds_vehicles:definitions processed_actions append from storage reds_vehicles:definitions working_action

# Run again if unprocessed action entries remain
execute if data storage reds_vehicles:definitions unprocessed_actions[0] run function reds_vehicles:define/process_actions_loop
