# Cleans up temporary scores/storage used in reds_vehicles:define/part/parse
data remove storage reds_vehicles:definitions new_item
data remove storage reds_vehicles:definitions args.string
scoreboard players reset vehicle.groups_prepend_result vehicle.local
scoreboard players reset vehicle.prepend_macro_status vehicle.local
