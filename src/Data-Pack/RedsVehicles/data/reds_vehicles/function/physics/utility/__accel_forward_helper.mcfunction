# Uses the current position to obtain the result of adding two vectors

# Store vector sum in location that can be used elsewhere
data modify storage reds_vehicles:physics temp.x set from entity @s Pos[0]
data modify storage reds_vehicles:physics temp.y set from entity @s Pos[1]
data modify storage reds_vehicles:physics temp.z set from entity @s Pos[2]

# Remove the temporary entity
kill @s[type=minecraft:marker]
