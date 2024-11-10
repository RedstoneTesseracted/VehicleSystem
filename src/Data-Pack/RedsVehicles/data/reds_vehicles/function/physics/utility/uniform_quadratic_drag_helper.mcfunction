# This function is used by reds_vehicles:physics/types/simple_quadratic_drag 
# to assist in the calculating the drag force

# Run calculations
function reds_vehicles:physics/utility/__uniform_quadratic_drag_helper

# Destroy temporary entity
kill @s[type=minecraft:block_display]
