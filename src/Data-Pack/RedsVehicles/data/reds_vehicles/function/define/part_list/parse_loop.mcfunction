# This function handles the looping aspect of reds_vehicles:define/part_list/parse
#
# Does NOT return a success/failure code

# Pop the first element in the list
data modify storage reds_vehicles:definitions working_part set from storage reds_vehicles:definitions unprocessed_parts[0]
data remove storage reds_vehicles:definitions unprocessed_parts[0]

# Process parts element
execute unless function reds_vehicles:define/part/parse run scoreboard players set vehicle.part_list_error vehicle.local 1

# Add processed element to processed array
data modify storage reds_vehicles:definitions processed_parts append from storage reds_vehicles:definitions working_part

# Run again if unprocessed part entries remain
execute if data storage reds_vehicles:definitions unprocessed_parts[0] run function reds_vehicles:define/part_list/parse_loop
