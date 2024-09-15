# This function handles the looping aspect of reds_vehicles:define/default_score_list/parse
#
# Does NOT return a success/failure code

# Pop the first element in the list
data modify storage reds_vehicles:definitions working_default_score set from storage reds_vehicles:definitions unprocessed_default_scores[0]
data remove storage reds_vehicles:definitions unprocessed_default_scores[0]

# Process default_scores element
execute unless function reds_vehicles:define/default_score/parse run scoreboard players set vehicle.default_score_list_error vehicle.local 1

# Add processed element to processed array
data modify storage reds_vehicles:definitions processed_default_scores append from storage reds_vehicles:definitions working_default_score

# Run again if unprocessed default_score entries remain
execute if data storage reds_vehicles:definitions unprocessed_default_scores[0] run function reds_vehicles:define/default_score_list/parse_loop
