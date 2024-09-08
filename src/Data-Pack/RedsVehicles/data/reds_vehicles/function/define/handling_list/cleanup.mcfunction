# Cleans up temporary scores used in reds_vehicles:define/handling_list/parse
scoreboard players reset vehicle.handling_list_error vehicle.local
data remove storage reds_vehicles:definitions unprocessed_handling
data remove storage reds_vehicles:definitions processed_handling
data remove storage reds_vehicles:definitions working_handling
