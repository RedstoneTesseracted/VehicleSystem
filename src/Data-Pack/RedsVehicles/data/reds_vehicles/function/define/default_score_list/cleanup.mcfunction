# Cleans up temporary scores used in reds_vehicles:define/default_score_list/parse
scoreboard players reset vehicle.default_score_list_error vehicle.local
data remove storage reds_vehicles:definitions unprocessed_default_scores
data remove storage reds_vehicles:definitions processed_default_scores
data remove storage reds_vehicles:definitions working_default_score
