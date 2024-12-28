# Function used by ./__motion_macro to manage the temporary marker entity

# Store result in storage
data modify storage reds_vehicles:inputs input.motion.x set from entity @s Pos[0]
data modify storage reds_vehicles:inputs input.motion.z set from entity @s Pos[2]

# Destroy temporary entity
kill @s[type=minecraft:marker]
