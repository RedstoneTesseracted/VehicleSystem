# This function gives all vehicle summoning items to the executor

# Retrieve list of existing vehicles
data modify storage reds_vehicles:definitions ungiven_items set from storage reds_vehicles:definitions processed
execute if data storage reds_vehicles:definitions ungiven_items[0] run function reds_vehicles:items/__give_spawn_eggs

# Clear temporary storage
data remove storage reds_vehicles:definitions ungiven_items
