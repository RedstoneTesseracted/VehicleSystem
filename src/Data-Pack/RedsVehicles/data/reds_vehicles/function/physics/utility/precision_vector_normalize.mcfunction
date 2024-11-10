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

# Execute function macro with wrapped function
# Wrapping the macro prevents the /kill command below from being thwarted when
# the macro fails to compile
function reds_vehicles:physics/utility/__precision_vector_normalize with storage reds_vehicles:physics temp

# Remove temporary entity
kill @s[type=minecraft:block_display]
