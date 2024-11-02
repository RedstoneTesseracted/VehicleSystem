# This function is used by reds_vehicles:physics/types/side_linear_drag to shift execution context 
# to a temporary display entity
#
# This allows us to use @s to improve performance
#
# The actual implementation of this function is implemented in __side_drag_helper to prevent
# macro compilation failures from thwarting the /kill command at the bottom of this file

function reds_vehicles:physics/utility/__side_drag_helper with storage reds_vehicles:physics temp


# Remove the temporary display entity
kill @s[type=minecraft:block_display]

