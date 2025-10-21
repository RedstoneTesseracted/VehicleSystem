# This function lists the names of loaded vehicles using a recursive loop
#
# It is called from reds_vehicles:commands/list_vehicles

# Print message in chat containing the name
tellraw @s [{text:" • ",color:"blue"},{nbt:"unshown_vehicles[0].name",storage:"reds_vehicles:definitions"}]

# Remove entry and run again if entries remain
data remove storage reds_vehicles:definitions unshown_vehicles[0]
execute if data storage reds_vehicles:definitions unshown_vehicles[0] run function reds_vehicles:commands/list_vehicles_loop

