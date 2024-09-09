# This function is used to parse/validate a single action tag
# The action tag to parse/validate must be at "working_action"
# under the "reds_vehicles:definitions" storage
#
# The input tag is modified in-place
#
# Return 1 = Passed
# Return 0 = Failed
#

# Arguments field is required regardless of action type
execute unless data storage reds_vehicles:definitions working_action.arguments run function reds_vehicles:define/action/report/missing_arguments
execute unless data storage reds_vehicles:definitions working_action.arguments run function reds_vehicles:define/action/exit_fail

# Attempt to run corresponding type validation
scoreboard players set vehicle.action_exists vehicle.local 0
execute store result score vehicle.action_type_status vehicle.local run function reds_vehicles:define/action/parse_type_specific with storage reds_vehicles:definitions working_action

# Handle validation failure
execute if score vehicle.action_type_status vehicle.local matches 0 run function reds_vehicles:define/action/report/type_macro_fail
execute if score vehicle.action_type_status vehicle.local matches 0 run function reds_vehicles:define/action/exit_fail

execute if score vehicle.action_exists vehicle.local matches 0 run function reds_vehicles:define/action/report/unknown_action
execute if score vehicle.action_exists vehicle.local matches 0 run function reds_vehicles:define/action/exit_fail

execute if score vehicle.action_type_status vehicle.local matches -1 run return run function reds_vehicles:define/action/exit_fail


# Success!
return run function reds_vehicles:define/action/exit_success

