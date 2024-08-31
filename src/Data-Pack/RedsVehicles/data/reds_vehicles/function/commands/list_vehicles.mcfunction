# This function lists out the loaded vehicles to the player that ran it
#
# It is run using an advancement trigger

# Reset the advancement trigger
advancement revoke @s only reds_vehicles:hidden/listvehicles_trigger

# Reset the scoreboard trigger
scoreboard players reset @s vehicle.listvehicles
scoreboard players enable @s vehicle.listvehicles

# Print header
tellraw @s [{"translate":"reds_vehicles.list_vehicles.header","fallback":"Loaded Vehicles:","color":"#00FF00","underlined":true},{"text":"\n"}]

# Copy the processed vehicles table for iteration
data modify storage reds_vehicles:definitions unshown_vehicles set from storage reds_vehicles:definitions processed
execute if data storage reds_vehicles:definitions unshown_vehicles[0] run function reds_vehicles:commands/list_vehicles_loop
data remove storage reds_vehicles:definitions unshown_vehicles
