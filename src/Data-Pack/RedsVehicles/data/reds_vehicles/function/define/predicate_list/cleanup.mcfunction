# Cleans up temporary scores/storage used in reds_vehicles:define/predicate_list/parse
data remove storage reds_vehicles:definitions unprocessed_predicates
data remove storage reds_vehicles:definitions predicate_args
scoreboard players reset vehicle.concat_macro_status vehicle.local
scoreboard players reset vehicle.predicate_macro_status vehicle.local
