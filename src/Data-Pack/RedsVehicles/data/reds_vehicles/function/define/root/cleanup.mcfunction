# Cleans up temporary scores/storage used in reds_vehicles:define/root/parse
data remove storage reds_vehicles:definitions working_handling_list
data remove storage reds_vehicles:definitions working_input_list
data remove storage reds_vehicles:definitions working_base_gravity
data remove storage reds_vehicles:definitions working_part_list
data remove storage reds_vehicles:definitions working_event_list
data remove storage reds_vehicles:definitions working_physics_list
data remove storage reds_vehicles:definitions working_entities
data remove storage reds_vehicles:definitions working_seat
data remove storage reds_vehicles:definitions working_hitbox
data remove storage reds_vehicles:definitions working_ground_offset
data remove storage reds_vehicles:definitions working_bonus_list
data remove storage reds_vehicles:definitions working_default_score_list
scoreboard players reset vehicle.ground_offset vehicle.local
scoreboard players reset vehicle.min_version vehicle.local
scoreboard players reset vehicle.current_version vehicle.local
