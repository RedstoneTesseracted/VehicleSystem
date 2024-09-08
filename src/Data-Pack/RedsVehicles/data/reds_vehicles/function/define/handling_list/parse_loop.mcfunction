# This function handles the looping aspect of reds_vehicles:define/handling_list/parse_loop
#
# Does NOT return a success/failure code

# Pop the first element in the list
data modify storage reds_vehicles:definitions working_handling set from storage reds_vehicles:definitions unprocessed_handling[0]
data remove storage reds_vehicles:definitions unprocessed_handling[0]

# Process handling element
execute unless function reds_vehicles:define/handling/parse run scoreboard players set vehicle.handling_list_error vehicle.local 1
execute if data storage reds_vehicles:definitions working_handling.input_group run function reds_vehicles:define/handling_list/mark_input_group
data remove storage reds_vehicles:definitions working_handling.input_group

# Run again if unprocessed handling entries remain
execute if data storage reds_vehicles:definitions unprocessed_handling[0] run function reds_vehicles:define/process_handling_loop
