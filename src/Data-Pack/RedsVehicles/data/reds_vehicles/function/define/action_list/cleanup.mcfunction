# Cleans up temporary scores used in reds_vehicles:define/action_list/parse
scoreboard players reset vehicle.action_list_error vehicle.local
data remove storage reds_vehicles:definitions unprocessed_actions
data remove storage reds_vehicles:definitions processed_actions
data remove storage reds_vehicles:definitions working_action
