# Handles the looping functionality of reds_vehicles:items/give_spawn_eggs

# Give spawn egg for vehicle at current index
function reds_vehicles:items/give_spawn_egg with storage reds_vehicles:definitions ungiven_items[0]

# Remove current index and give next item if any remain
data remove storage reds_vehicles:definitions ungiven_items[0]
execute if data storage reds_vehicles:definitions ungiven_items[0] run function reds_vehicles:items/__give_spawn_eggs
