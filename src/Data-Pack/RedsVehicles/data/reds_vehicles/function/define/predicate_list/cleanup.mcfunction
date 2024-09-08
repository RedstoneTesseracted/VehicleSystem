# Cleans up temporary scores/storage used in reds_vehicles:define/physics/parse
data remove storage reds_vehicles:definitions unprocessed_predicates
data remove storage reds_vehicles:definitions predicate_args
scoreboard players reset vehicle.concat_macro_status vehicle.local
