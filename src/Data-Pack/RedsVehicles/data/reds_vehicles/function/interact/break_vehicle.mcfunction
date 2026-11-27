# This function is called whenever a player punches a vehicle
# It is triggered using a hidden advancement, and is therefore run BY and AT the player

# Figure out who we've punched
tag @e remove vehicle.click_target
tag @a remove vehicle.context
tag @s add vehicle.context
execute as @e[tag=vehicle.hitbox] if function reds_vehicles:interact/check_hitbox_attacker run tag @s add vehicle.click_target
tag @a remove vehicle.context

# Abort if we're riding that vehicle.  This SHOULD be caught by the advancement, but just in case anything changes...
execute on vehicle on vehicle on passengers run tag @s[tag=vehicle.click_target,tag=vehicle.hitbox] remove vehicle.click_target

# Destroy the targeted vehicle
execute if entity @s[gamemode=!creative] as @n[tag=vehicle.click_target] on vehicle at @s run function reds_vehicles:summon/drop
execute as @n[tag=vehicle.click_target] on vehicle at @s run function reds_vehicles:summon/destroy

# Reset tags
tag @e remove vehicle.click_target

# Reset advancement trigger
advancement revoke @a only reds_vehicles:hidden/break_vehicle
