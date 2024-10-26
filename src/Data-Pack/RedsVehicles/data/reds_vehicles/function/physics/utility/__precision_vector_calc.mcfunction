# Used by reds_vehicles:physics/utility/precision_vector_calc to obtain the vector between two points

# This entity will have been summoned at the world position corresponding to the computed vector
data modify storage reds_vehicles:physics temp.dx set from entity @s Pos[0]
data modify storage reds_vehicles:physics temp.dy set from entity @s Pos[1]
data modify storage reds_vehicles:physics temp.dz set from entity @s Pos[2]

# Remove temporary entity
kill @s[type=minecraft:marker]
