# This function is used to parse/validate a single handling tag
# The handling tag to parse/validate must be at "working_handling"
# under the "reds_vehicles:definitions" storage
#
# The input tag is modified in-place
#
# Return 1 = Passed
# Return 0 = Failed

# Check for input field
execute unless data storage reds_vehicles:definitions working_handling.input run function reds_vehicles:define/handling/report/input_missing
execute unless data storage reds_vehicles:definitions working_handling.input run return run function reds_vehicles:define/handling/exit_fail

# Check for operation field
execute unless data storage reds_vehicles:definitions working_handling.operation run function reds_vehicles:define/handling/report/operation_missing
execute unless data storage reds_vehicles:definitions working_handling.operation run return run function reds_vehicles:define/handling/exit_fail

# Check for variable field
execute unless data storage reds_vehicles:definitions working_handling.variable run function reds_vehicles:define/handling/report/variable_missing
execute unless data storage reds_vehicles:definitions working_handling.variable run return run function reds_vehicles:define/handling/exit_fail

# Scale field (optional, defaults to no scale)
execute unless data storage reds_vehicles:definitions working_handling.scale run data modify storage reds_vehicles:definitions working_handling.scale set value {source:"none"}
data modify storage reds_vehicles:definitions working_scale set from storage reds_vehicles:definitions working_handling.scale
execute unless function reds_vehicles:define/scale/parse run return run function reds_vehicles:define/handling/exit_fail
data modify storage reds_vehicles:definitions working_handling.scale set from storage reds_vehicles:definitions working_scale

# Precision field (optional, defaults to 1)
execute unless data storage reds_vehicles:definitions working_handling.precision run data modify storage reds_vehicles:definitions working_handling.precision set value 1

# Handle this particular type of input
execute store result score vehicle.input_parse_status vehicle.local run function reds_vehicles:define/handling/parse_input_specific with storage reds_vehicles:definitions working_handling
execute if score vehicle.input_parse_status vehicle.local matches 0 run function reds_vehicles:define/handling/report/input_macro_fail
execute unless score vehicle.input_parse_status vehicle.local matches 1 run return run function reds_vehicles:define/handling/exit_fail


# Success!
return run function reds_vehicles:define/handling/exit_success

