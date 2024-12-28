# This function is called whenever a player interacts with an empty vehicle hitbox
# It is triggered using a hidden advancement, and is therefore run BY and AT the player

# Figure out who we've clicked
tag @e remove vehicle.click_target
tag @a remove vehicle.context
tag @s add vehicle.context
execute as @e[tag=vehicle.hitbox] if function reds_vehicles:interact/check_hitbox_target run tag @s add vehicle.click_target
tag @a remove vehicle.context

# Find the first available seat
execute as @e[tag=vehicle.hitbox,tag=vehicle.click_target,limit=1] on vehicle run function reds_vehicles:vehicle/mark_next_available_seat

# Make the player mount the first available seat
ride @s mount @e[tag=vehicle.seat,tag=vehicle.next_available_seat,limit=1]

# Reset tags
tag @e remove vehicle.click_target
tag @e remove vehicle.next_available_seat

# Reset advancement trigger
advancement revoke @a only reds_vehicles:hidden/hitbox_interact
