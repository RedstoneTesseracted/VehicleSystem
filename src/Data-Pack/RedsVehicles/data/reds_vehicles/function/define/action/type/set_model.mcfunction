# Action: set custom model data value

# Confirm existence
scoreboard players set vehicle.action_exists vehicle.local 1

# Name and value fields are required
execute unless data storage reds_vehicles:definitions working_action.arguments.name run function reds_vehicles:define/action/report/model/missing_name
execute unless data storage reds_vehicles:definitions working_action.arguments.name run return 0
execute unless data storage reds_vehicles:definitions working_action.arguments.value run function reds_vehicles:define/action/report/model/missing_value
execute unless data storage reds_vehicles:definitions working_action.arguments.value run return 0

# Success!
return 1
