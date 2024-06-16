# This function is called whenever a player interacts with an empty vehicle seat
# It is triggered using a hidden advancement, and is therefore run BY and AT the player

# Figure out who we've clicked
tag @e remove vehicle.click_target
tag @a remove vehicle.context
tag @s add vehicle.context
execute as @e[tag=vehicle.seat] if function reds_vehicles:interact/check_seat_target run tag @s add vehicle.click_target
tag @a remove vehicle.context

# Make the player mount the found vehicle seat
ride @s mount @e[tag=vehicle.seat,tag=vehicle.click_target,limit=1]

# Reset tags
tag @e remove vehicle.click_target

# Reset advancement trigger
advancement revoke @a only reds_vehicles:hidden/seat_interact
