# This function announces changes in the number of defined vehicles
# It is called by the init function IF the vehicle.config score for 
# vehicle.config.show_vehicle_count_on_reload matches 1

# Get and show total number of vehicles
execute store result score vehicle.defined_vehicle_count vehicle.constants run data get storage reds_vehicles:definitions processed
tellraw @a[gamemode=creative] [{text:"Reloaded with ",color:"green"},{"score":{"objective":"vehicle.constants","name":"vehicle.defined_vehicle_count"}},{text:" defined vehicles"}]
