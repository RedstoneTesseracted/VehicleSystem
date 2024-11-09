# Action: apply a potion effect to a passenger

# Confirm existence
scoreboard players set vehicle.action_exists vehicle.local 1

# Text field is required
execute unless data storage reds_vehicles:definitions working_action.arguments.text run function reds_vehicles:define/action/report/message/missing_text
execute unless data storage reds_vehicles:definitions working_action.arguments.text run return 0

# Success!
return 1
