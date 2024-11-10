# This utility function is used for obtaining vectors with floating-point precision
#
# To use it, store the first point somewhere in the temp tag in the reds_vehicles:physics storage:
#   data modify storage reds_vehicles:physics temp.x1 set from entity @s Pos[0]
#   data modify storage reds_vehicles:physics temp.y1 set from entity @s Pos[1]
#   data modify storage reds_vehicles:physics temp.z1 set from entity @s Pos[2]
#
# Then, invoke this function with a command similar to:
#   execute positioned ^ ^ ^1 summon minecraft:marker run function reds_vehicles:physics/utility/precision_vector_calc with storage reds_vehicles:physics temp

# Obtain second point using function macro shenanigans
$execute \
rotated 90 0 positioned ^ ^ ^$(x1) \
rotated 0 90 positioned ^ ^ ^$(y1) \
rotated 180 0 positioned ^ ^ ^$(z1) \
summon minecraft:marker run function reds_vehicles:physics/utility/__precision_vector_calc

# Remove temporary entity
kill @s[type=minecraft:marker]
