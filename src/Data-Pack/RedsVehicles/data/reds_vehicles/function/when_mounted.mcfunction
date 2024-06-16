# This function handles the per-tick functionality of vehicles when they are mounted by the player
# It is run BY and AT the vehicle base entity WHEN its seat is occupied

# Get direction the player is trying to move in
function reds_vehicles:input/gather

# Apply hazard protection bonus effects
function reds_vehicles:protection/apply_protection

# Update the model rotation to match the player's facing direction
tag @e[tag=vehicle.context] remove vehicle.context
execute on passengers if entity @s[tag=vehicle.seat] on passengers run tag @s add vehicle.context
execute on passengers if entity @s[tag=vehicle.model] run data modify entity @s Rotation[0] set from entity @p[tag=vehicle.context] Rotation[0]
tag @e[tag=vehicle.context] remove vehicle.context 
