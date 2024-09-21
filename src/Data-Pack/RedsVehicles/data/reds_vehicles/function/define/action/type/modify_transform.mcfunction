# Action: set custom model data value

# Confirm existence
scoreboard players set vehicle.action_exists vehicle.local 1

# Name OR groups fields are required (but not both)
execute unless data storage reds_vehicles:definitions working_action.arguments.name unless data storage reds_vehicles:definitions working_action.arguments.group run function reds_vehicles:define/action/report/modify_transform/group_nor_name
execute unless data storage reds_vehicles:definitions working_action.arguments.name unless data storage reds_vehicles:definitions working_action.arguments.group run return 0
execute if data storage reds_vehicles:definitions working_action.arguments.name if data storage reds_vehicles:definitions working_action.arguments.group run function reds_vehicles:define/action/report/modify_transform/group_and_name
execute if data storage reds_vehicles:definitions working_action.arguments.name if data storage reds_vehicles:definitions working_action.arguments.group run return 0

# Transform field is required
execute unless data storage reds_vehicles:definitions working_action.arguments.transform run function reds_vehicles:define/action/report/modify_transform/missing_transform
execute unless data storage reds_vehicles:definitions working_action.arguments.transform run return 0

# Property field is required
execute unless data storage reds_vehicles:definitions working_action.arguments.property run function reds_vehicles:define/action/report/modify_transform/missing_property
execute unless data storage reds_vehicles:definitions working_action.arguments.property run return 0

# Source field is required
execute unless data storage reds_vehicles:definitions working_action.arguments.source run function reds_vehicles:define/action/report/modify_transform/missing_source
execute unless data storage reds_vehicles:definitions working_action.arguments.source run return 0

# Scale field is optional (defaults to 1.0)
execute unless data storage reds_vehicles:definitions working_action.arguments.scale run data modify storage reds_vehicles:definitions working_action.arguments.scale set value 1.0

# Convert name or group field into target selector
scoreboard players set vehicle.selector_macro_status vehicle.local 0
execute if data storage reds_vehicles:definitions working_action.arguments.name store result score vehicle.selector_macro_status vehicle.local run function reds_vehicles:define/action/__generate_name_selector with storage reds_vehicles:definitions working_action.arguments
execute if data storage reds_vehicles:definitions working_action.arguments.name if score vehicle.selector_macro_status vehicle.local matches 0 run function reds_vehicles:define/action/report/modify_transform/name_macro_fail
execute if data storage reds_vehicles:definitions working_action.arguments.name if score vehicle.selector_macro_status vehicle.local matches 0 run return 0

execute if data storage reds_vehicles:definitions working_action.arguments.group store result score vehicle.selector_macro_status vehicle.local run function reds_vehicles:define/action/__generate_group_selector with storage reds_vehicles:definitions working_action.arguments
execute if data storage reds_vehicles:definitions working_action.arguments.group if score vehicle.selector_macro_status vehicle.local matches 0 run function reds_vehicles:define/action/report/modify_transform/group_macro_fail
execute if data storage reds_vehicles:definitions working_action.arguments.group if score vehicle.selector_macro_status vehicle.local matches 0 run return 0

# Remove name/group fields now that we've converted them into the "selector" field that's actually used
data remove storage reds_vehicles:definitions working_action.arguments.name
data remove storage reds_vehicles:definitions working_action.arguments.group

# Auto-generate "inverse_precision" field if not already present
data modify storage reds_vehicles:definitions args.variable set from storage reds_vehicles:definitions working_action.arguments.source
data remove storage reds_vehicles:precision out
execute unless data storage reds_vehicles:definitions working_action.arguments.inverse_precision run function reds_vehicles:define/precision/lookup_inverse with storage reds_vehicles:definitions args
execute unless data storage reds_vehicles:definitions working_action.arguments.inverse_precision unless data storage reds_vehicles:precision out run function reds_vehicles:define/action/report/modify_transform/precision_macro_fail
data remove storage reds_vehicles:definitions args.variable
execute unless data storage reds_vehicles:definitions working_action.arguments.inverse_precision unless data storage reds_vehicles:precision out run return 0
execute unless data storage reds_vehicles:definitions working_action.arguments.inverse_precision run data modify storage reds_vehicles:definitions working_action.arguments.inverse_precision set from storage reds_vehicles:precision out
data remove storage reds_vehicles:precision out

# Success!
return 1
