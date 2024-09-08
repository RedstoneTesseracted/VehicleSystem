# This function clears, reloads, and reprocesses the global vehicle definition table
# It is called during datapack load (such as /reload) or can be called manually by an operator

# Reset the NBT storage containing the tables
data remove storage reds_vehicles:definitions processed
data remove storage reds_vehicles:definitions vehicles
data merge storage reds_vehicles:definitions {vehicles:[],processed:[],errors:[]}
#data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
#function reds_vehicles:define/logging/reset
function #reds_vehicles:declare_vehicles

# Reload all enums tables
function #reds_vehicles:declare_enums

# Process all declared vehicles
data modify storage reds_vehicles:definitions names set value []
data modify storage reds_vehicles:definitions unprocessed set from storage reds_vehicles:definitions vehicles
execute if data storage reds_vehicles:definitions unprocessed[0] run function reds_vehicles:define/process_loop

# Message creative players about defined vehicle count (if enabled)
execute if score config vehicle.config.show_vehicle_count_on_reload matches 1 run function reds_vehicles:define/notify/announce_vehicle_count

# Message all players about detected errors (if enabled)
execute if score config vehicle.config.notify_errors_on_reload matches 1 run function reds_vehicles:define/notify/announce_errors
