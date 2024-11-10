# Grabs coordinates from a newly summoned entity before destroying it
# Called from reds_vehicles:physics/utility/precision_roll_helper_part2

# Grab coordinates
data modify storage reds_vehicles:physics temp.dx set from entity @s Pos[0]
data modify storage reds_vehicles:physics temp.dz set from entity @s Pos[1]
data modify storage reds_vehicles:physics temp.dy set from entity @s Pos[2]

# Remove temporary entity
kill @s[type=minecraft:marker]

