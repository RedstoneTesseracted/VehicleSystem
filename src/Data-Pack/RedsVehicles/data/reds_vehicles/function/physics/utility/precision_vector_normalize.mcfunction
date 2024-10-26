# This utility function is used for separating a vector's magnitude and direction while maintaining floating-point precision
#
# To use it, store the vector in the temp tag in the reds_vehicles:physics storage:
#   data modify storage reds_vehicles:physics temp.vx set from ...
#   data modify storage reds_vehicles:physics temp.vy set from ...
#   data modify storage reds_vehicles:physics temp.vz set from ...
#
# Then, invoke this function with a command similar to:
#   execute summon minecraft:block_display run function reds_vehicles:physics/utility/precision_vector_normalize with storage reds_vehicles:physics temp
#
# The normalized vector is stored back in temp.nvx/nvy/nvz
# The magnitude is stored in temp.vmag
#

# Funky transformation shenanigans to normalize vector
$data modify entity @s transformation.left_rotation set value [$(vx)f,$(vy)f,$(vz)f,0.0f]
data modify storage reds_vehicles:physics temp.nvx set from entity @s transformation.left_rotation[0]
data modify storage reds_vehicles:physics temp.nvy set from entity @s transformation.left_rotation[1]
data modify storage reds_vehicles:physics temp.nvz set from entity @s transformation.left_rotation[2]

# Funky transformation shenanigans to compute magnitude
$data modify entity @s transformation set value [\
$(vx)f,0.0f,0.0f,0.0f,\
$(vy)f,0.0f,0.0f,0.0f,\
$(vz)f,0.0f,0.0f,0.0f,\
0.0f,0.0f,0.0f,1.0f]
data modify storage reds_vehicles:physics temp.vmag set from entity @s transformation.scale[0]

# Remove temporary entity
kill @s[type=minecraft:block_display]
