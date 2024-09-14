# Cleans up temporary scores/storage used in reds_vehicles:define/event/parse
scoreboard players reset vehicle.trigger_macro_status vehicle.local
scoreboard players reset vehicle.join_macro_status vehicle.local
scoreboard players reset vehicle.action_list_length vehicle.local
data remove storage reds_vehicles:definitions working_predicates
data remove storage reds_vehicles:definitions working_predicate
data remove storage reds_vehicles:definitions working_action_list
data remove storage reds_vehicles:definitions event_args
