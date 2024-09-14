# Cleans up temporary scores/storage used in reds_vehicles:define/root_list/parse
data remove storage reds_vehicles:definitions unprocessed_vehicles
data remove storage reds_vehicles:definitions working_root
scoreboard players reset vehicle.root_parse_result vehicle.local
