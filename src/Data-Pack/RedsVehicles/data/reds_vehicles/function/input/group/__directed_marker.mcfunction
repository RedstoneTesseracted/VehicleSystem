# Function used by ./__directed_macro to manage the temporary marker entity

# Store result in storage
data modify storage reds_vehicles:inputs input.directed.x set from entity @s Pos[0]
data modify storage reds_vehicles:inputs input.directed.y set from entity @s Pos[1]
data modify storage reds_vehicles:inputs input.directed.z set from entity @s Pos[2]

# Destroy temporary entity
kill @s[type=minecraft:marker]
