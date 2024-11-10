# Cleans up temporary scores/storage used in reds_vehicles:define/physics/parse
data remove storage reds_vehicles:definitions working_predicate
data remove storage reds_vehicles:definitions working_predicates
scoreboard players reset vehicle.physics_type_exists vehicle.local
scoreboard players reset vehicle.compare_changed vehicle.local
scoreboard players reset vehicle.inverse_success vehicle.local
scoreboard players reset vehicle.float_convert_success vehicle.local
