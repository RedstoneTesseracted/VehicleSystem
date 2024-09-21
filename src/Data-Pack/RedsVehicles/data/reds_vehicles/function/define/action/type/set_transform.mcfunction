# Action: set custom model data value

# Confirm existence
scoreboard players set vehicle.action_exists vehicle.local 1

# Name OR groups fields are required (but not both)
execute unless data storage reds_vehicles:definitions working_action.arguments.name unless data storage reds_vehicles:definitions working_action.arguments.group run function reds_vehicles:define/action/report/set_transform/group_nor_name
execute unless data storage reds_vehicles:definitions working_action.arguments.name unless data storage reds_vehicles:definitions working_action.arguments.group run return 0
execute if data storage reds_vehicles:definitions working_action.arguments.name if data storage reds_vehicles:definitions working_action.arguments.group run function reds_vehicles:define/action/report/set_transform/group_and_name
execute if data storage reds_vehicles:definitions working_action.arguments.name if data storage reds_vehicles:definitions working_action.arguments.group run return 0

# Transform field is required
execute unless data storage reds_vehicles:definitions working_action.arguments.transform run function reds_vehicles:define/action/report/set_transform/missing_transform
execute unless data storage reds_vehicles:definitions working_action.arguments.transform run return 0

# Parameter field is required
execute unless data storage reds_vehicles:definitions working_action.arguments.parameter run function reds_vehicles:define/action/report/set_transform/missing_parameter
execute unless data storage reds_vehicles:definitions working_action.arguments.parameter run return 0


# Convert name or group field into target selector
scoreboard players set vehicle.selector_macro_status vehicle.local 0
execute if data storage reds_vehicles:definitions working_action.arguments.name store result score vehicle.selector_macro_status vehicle.local run function reds_vehicles:define/action/__generate_name_selector with storage reds_vehicles:definitions working_action.arguments
execute if data storage reds_vehicles:definitions working_action.arguments.name if score vehicle.selector_macro_status vehicle.local matches 0 run function reds_vehicles:define/action/report/set_transform/name_macro_fail
execute if data storage reds_vehicles:definitions working_action.arguments.name if score vehicle.selector_macro_status vehicle.local matches 0 run return 0

execute if data storage reds_vehicles:definitions working_action.arguments.group store result score vehicle.selector_macro_status vehicle.local run function reds_vehicles:define/action/__generate_group_selector with storage reds_vehicles:definitions working_action.arguments
execute if data storage reds_vehicles:definitions working_action.arguments.group if score vehicle.selector_macro_status vehicle.local matches 0 run function reds_vehicles:define/action/report/set_transform/group_macro_fail
execute if data storage reds_vehicles:definitions working_action.arguments.group if score vehicle.selector_macro_status vehicle.local matches 0 run return 0

# Remove name/group fields now that we've converted them into the "selector" field that's actually used
data remove storage reds_vehicles:definitions working_action.arguments.name
data remove storage reds_vehicles:definitions working_action.arguments.group



# Success!
return 1
