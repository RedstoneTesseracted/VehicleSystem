# Cleans up temporary scores used in reds_vehicles:define/handling_list/parse
scoreboard players reset vehicle.handling_list_error vehicle.local
scoreboard players reset vehicle.mark_input_group_status vehicle.local
scoreboard players reset vehicle.working_handling_status vehicle.local
data remove storage reds_vehicles:definitions unprocessed_handling
data remove storage reds_vehicles:definitions processed_handling
data remove storage reds_vehicles:definitions working_handling
data remove storage reds_vehicles:definitions unprocessed_working_input_list
