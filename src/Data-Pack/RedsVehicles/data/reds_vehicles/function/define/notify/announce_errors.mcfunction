# This function announces changes in the number of defined vehicles
# It is called by the init function IF the vehicle.config score for 
# vehicle.config.notify_errors_on_reload matches 1

# Get the total number of requested and processed vehicle definitions
execute store result score vehicle.failed_definitions vehicle.local run data get storage reds_vehicles:definitions vehicles
execute store result score vehicle.defined_vehicle_count vehicle.constants run data get storage reds_vehicles:definitions processed
scoreboard players operation vehicle.failed_definitions vehicle.local -= vehicle.defined_vehicle_count vehicle.constants

# Get the total number of errors
execute store result score vehicle.error_count vehicle.constants run data get storage reds_vehicles:definitions errors

# Show the number of vehicles that failed to load.  If all vehicles loaded but errors occurred anyways, use a fallback message
execute if score vehicle.failed_definitions vehicle.local matches 1.. run tellraw @a [{"text": "[Red's Vehicles]: ","color": "red"},{"translate": "reds_vehicles.notify.errors","fallback": "%1$s vehicles could not be loaded.  Use %2$s for more information","with": [{"score": {"name": "vehicle.failed_definitions","objective": "vehicle.local"},"color": "gold","bold": true},{"text": "/trigger vehicle.showlog","color": "gold","underlined": true,"clickEvent": {"action": "suggest_command","value": "/trigger vehicle.showlog"},"hoverEvent": {"action": "show_text","value": {"text": "/trigger vehicle.showlog"}}}],"color": "red"}]
execute if score vehicle.failed_definitions vehicle.local matches 0 if score vehicle.error_count vehicle.constants matches 1.. run tellraw @a [{"text": "[Red's Vehicles]: ","color": "red"},{"translate": "reds_vehicles.notify.errors","fallback": "All vehicles were loaded, but %1$s errors were raised.  Use %2$s for more information","with": [{"score": {"name": "vehicle.error_count","objective": "vehicle.local"},"color": "gold","bold": true},{"text": "/trigger vehicle.showlog","color": "gold","underlined": true,"clickEvent": {"action": "suggest_command","value": "/trigger vehicle.showlog"},"hoverEvent": {"action": "show_text","value": {"text": "/trigger vehicle.showlog"}}}],"color": "red"}]

