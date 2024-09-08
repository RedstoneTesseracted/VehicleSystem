# Cleans up temporary scores used in reds_vehicles:define/physics_list/parse
scoreboard players reset vehicle.physics_list_error vehicle.local
data remove storage reds_vehicles:definitions unprocessed_physics
data remove storage reds_vehicles:definitions processed_physics
data remove storage reds_vehicles:definitions working_physics
