# Action: summon particles

# Confirm existence
scoreboard players set vehicle.action_exists vehicle.local 1

# Name field is required
execute unless data storage reds_vehicles:definitions working_action.arguments.name run function reds_vehicles:define/action/report/particle_missing_name
execute unless data storage reds_vehicles:definitions working_action.arguments.name run return 0

# Set default values for offset, delta, count, and speed fields
execute unless data storage reds_vehicles:definitions working_action.arguments.offset run data modify storage reds_vehicles:definitions working_action.arguments.offset set value [0.0, 0.0, 0.0]
execute unless data storage reds_vehicles:definitions working_action.arguments.delta run data modify storage reds_vehicles:definitions working_action.arguments.delta set value [0.0, 0.0, 0.0]
execute unless data storage reds_vehicles:definitions working_action.arguments.count run data modify storage reds_vehicles:definitions working_action.arguments.count set value 1
execute unless data storage reds_vehicles:definitions working_action.arguments.speed run data modify storage reds_vehicles:definitions working_action.arguments.speed set value 0.0

# Convert offset and delta fields into a format compatible with function macros
data modify storage reds_vehicles:definitions working_action.arguments.offsetU set from storage reds_vehicles:definitions working_action.arguments.offset[0]
data modify storage reds_vehicles:definitions working_action.arguments.offsetV set from storage reds_vehicles:definitions working_action.arguments.offset[1]
data modify storage reds_vehicles:definitions working_action.arguments.offsetW set from storage reds_vehicles:definitions working_action.arguments.offset[2]
data remove storage reds_vehicles:definitions working_action.arguments.offset

data modify storage reds_vehicles:definitions working_action.arguments.deltaX set from storage reds_vehicles:definitions working_action.arguments.delta[0]
data modify storage reds_vehicles:definitions working_action.arguments.deltaY set from storage reds_vehicles:definitions working_action.arguments.delta[1]
data modify storage reds_vehicles:definitions working_action.arguments.deltaZ set from storage reds_vehicles:definitions working_action.arguments.delta[2]
data remove storage reds_vehicles:definitions working_action.arguments.delta

# Success!
return 1
