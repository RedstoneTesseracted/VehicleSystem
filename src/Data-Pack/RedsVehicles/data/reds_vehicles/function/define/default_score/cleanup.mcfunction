# Cleans up temporary scores/storage used in reds_vehicles:define/default_score/parse
scoreboard players reset vehicle.retrieved_precision vehicle.local
scoreboard players reset vehicle.precision_apply_status vehicle.local
data remove storage reds_vehicles:definitions args
