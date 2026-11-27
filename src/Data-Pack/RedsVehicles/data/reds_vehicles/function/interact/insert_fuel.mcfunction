# Function called by interact_callback whenever the player inserts fuel into a vehicle.
# interact_callback exits with this function, if run

# Insert fuel into target
scoreboard players set vehicle.inserted_fuel vehicle.local 0
execute store result score vehicle.inserted_fuel vehicle.local as @e[tag=vehicle.click_target,limit=1] on vehicle run function reds_vehicles:vehicle/add_fuel
title @s actionbar {translate: "reds_vehicles.messages.fuel_level", with: [{score: {name: "vehicle.current_fuel", objective: "vehicle.local"}}, {score: {name: "vehicle.max_fuel", objective: "vehicle.local"}}]}

# Consume fuel from main hand
execute if score vehicle.inserted_fuel vehicle.local matches 1.. run function reds_vehicles:interact/consume_fuel_can

# This is needed to exit properly from interact_callback
return run function reds_vehicles:interact/interact_callback_return
