# Cleans up temporary scores used in reds_vehicles:define/part_list/parse
scoreboard players reset vehicle.part_list_error vehicle.local
data remove storage reds_vehicles:definitions unprocessed_parts
data remove storage reds_vehicles:definitions processed_parts
data remove storage reds_vehicles:definitions working_part
