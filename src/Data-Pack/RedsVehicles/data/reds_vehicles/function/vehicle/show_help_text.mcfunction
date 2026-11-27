# This function retrieves the vehicle's help text (if defined) and shows it to the player with the vehicle.player.context tag
# This should be run BY the base vehicle entity

# Grab vehicle definition
execute unless function reds_vehicles:vehicle/grab_executor_definition run return fail

# Show help text if defined
execute unless data storage reds_vehicles:definitions current.help_text run return 0
tellraw @a[tag=vehicle.player.context] {nbt: "current.help_text", storage: "reds_vehicles:definitions", interpret: true}
return 1
