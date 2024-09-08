# Cleans up temporary scores/storage used in reds_vehicles:define/name/parse
scoreboard players reset vehicle.name_length vehicle.local
scoreboard players reset vehicle.vehicle_exists vehicle.local
data remove storage reds_vehicles:definitions args.name
