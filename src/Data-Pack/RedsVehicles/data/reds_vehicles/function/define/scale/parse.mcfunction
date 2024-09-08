# This function is used to parse/validate a single scale tag
# The handling tag to parse/validate must be at "working_scale"
# under the "reds_vehicles:definitions" storage
#
# The input tag is modified in-place
#
# Return 1 = Passed
# Return 0 = Failed

# Source field
execute unless data storage reds_vehicles:definitions working_scale.source run function reds_vehicles:define/scale/report/source_missing
execute unless data storage reds_vehicles:definitions working_scale.source run return run function reds_vehicles:define/scale/exit_fail

# Scale score_scale field (optional, defaults to 1.0)
execute unless data storage reds_vehicles:definitions working_scale.score_scale run data modify storage reds_vehicles:definitions working_handling.scale.score_scale set value 1.0

# Validate source type-specific fields
execute store result score vehicle.source_macro_status vehicle.local run function reds_vehicles:define/scale/source_specific_validate with storage reds_vehicles:definitions working_scale
execute if score vehicle.source_macro_status vehicle.local matches 0 run function reds_vehicles:define/scale/report/source_macro_fail
execute unless score vehicle.source_macro_status vehicle.local matches 1 run return run function reds_vehicles:define/scale/exit_fail

# Success!
return run function reds_vehicles:define/scale/exit_success
