# This function is called whenever a player interacts with an empty vehicle hitbox
# It is triggered using a hidden advancement, and is therefore run BY and AT the player

# Reset advancement trigger
advancement revoke @a only reds_vehicles:hidden/hitbox_interact

# Figure out who we've clicked
tag @e remove vehicle.click_target
tag @a remove vehicle.context
tag @s add vehicle.context
execute as @e[tag=vehicle.hitbox] if function reds_vehicles:interact/check_hitbox_target run tag @s add vehicle.click_target
tag @a remove vehicle.context

# If the player is holding a fuel can, insert more fuel instead of mounting
execute if predicate reds_vehicles:is_holding_fuel_can run return run function reds_vehicles:interact/insert_fuel

# Mount player onto vehicle

# Find the first available seat
execute as @e[tag=vehicle.hitbox,tag=vehicle.click_target,limit=1] on vehicle run function reds_vehicles:vehicle/mark_next_available_seat

# Make the player mount the first available seat
ride @s mount @e[tag=vehicle.seat,tag=vehicle.next_available_seat,limit=1]

# Apply camera multiplier
tag @s add vehicle.riding
function reds_vehicles:interact/apply_camera_multiplier

# Reset state
return run function reds_vehicles:interact/interact_callback_return
