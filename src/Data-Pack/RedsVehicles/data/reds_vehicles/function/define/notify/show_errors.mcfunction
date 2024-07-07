# This function shows the vehicle loading error log to all players that ran it

# Get the total number of errors
execute store result score vehicle.error_count vehicle.local run data get storage reds_vehicles:definitions errors

# Exit early if there were no errors
execute if score vehicle.error_count vehicle.local matches 0 run tellraw @s [{"text":"[Red's Vehicles]: ","color": "#00FF00"},{"translate": "reds_vehicles.notify.errors.header_none","fallback": "No errors logged while reloading vehicle definitions!","color": "green"}]
execute if score vehicle.error_count vehicle.local matches 0 run return 1

# Print error log header
tellraw @s [{"text":"[Red's Vehicles]: ","color": "#FF0000"},{"translate": "reds_vehicles.notify.errors.header","fallback": "%s errors logged while reloading vehicle definitions","with": [{"score": {"name": "vehicle.error_count","objective": "vehicle.local"},"color": "gold","bold": true}],"color": "red"}]

# Loop over errors array and print each formatted message
data modify storage reds_vehicles:definitions unprinted_errors set from storage reds_vehicles:definitions errors
function reds_vehicles:define/notify/show_errors_loop

# Clean up temporary storage
data remove storage reds_vehicles:definitions working_error
data remove storage reds_vehicles:definitions unprinted_errors
