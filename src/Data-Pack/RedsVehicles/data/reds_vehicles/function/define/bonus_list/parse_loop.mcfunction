# This function handles the looping aspect of reds_vehicles:define/bonus_list/parse
#
# Does NOT return a success/failure code

# Pop the first element in the list
data modify storage reds_vehicles:definitions working_bonus set from storage reds_vehicles:definitions unprocessed_bonuses[0]
data remove storage reds_vehicles:definitions unprocessed_bonuses[0]

# Process bonuss element
execute unless function reds_vehicles:define/bonus/parse run scoreboard players set vehicle.bonus_list_error vehicle.local 1

# Add processed element to processed array
data modify storage reds_vehicles:definitions processed_bonuses append from storage reds_vehicles:definitions working_bonus

# Run again if unprocessed bonus entries remain
execute if data storage reds_vehicles:definitions unprocessed_bonuses[0] run function reds_vehicles:define/bonus_list/parse_loop
