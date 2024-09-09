# Action: summon projectile

# Confirm existence
scoreboard players set vehicle.action_exists vehicle.local 1

# Name and direction fields are required
execute unless data storage reds_vehicles:definitions working_action.arguments.name run function reds_vehicles:define/action/report/projectile_missing_name
execute unless data storage reds_vehicles:definitions working_action.arguments.name run return 0
execute unless data storage reds_vehicles:definitions working_action.arguments.direction run function reds_vehicles:define/action/report/projectile_missing_direction
execute unless data storage reds_vehicles:definitions working_action.arguments.direction run return 0

# Success!
return 1
