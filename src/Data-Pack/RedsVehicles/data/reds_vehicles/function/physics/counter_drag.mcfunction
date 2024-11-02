# This function is used to counteract drag

# Call function macro that does all the work
function reds_vehicles:physics/__counter_drag with storage reds_vehicles:physics temp

# Safely remove this entity
kill @s[type=minecraft:block_display]
