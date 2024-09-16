# This function is used to parse/validate a single default_score tag
# The default_score tag to parse/validate must be at "working_default_score"
# under the "reds_vehicles:definitions" storage
#
# The input tag is modified in-place
#
# Return 1 = Passed
# Return 0 = Failed
#

# Name field is required
execute unless data storage reds_vehicles:definitions working_default_score.name run function reds_vehicles:define/default_score/report/missing_name
execute unless data storage reds_vehicles:definitions working_default_score.name run function reds_vehicles:define/default_score/exit_fail

# Value field is required
execute unless data storage reds_vehicles:definitions working_default_score.value run function reds_vehicles:define/default_score/report/missing_value
execute unless data storage reds_vehicles:definitions working_default_score.value run function reds_vehicles:define/default_score/exit_fail

# Precision field is optional - obtain default if name is recognized
data modify storage reds_vehicles:definitions args.variable set from storage reds_vehicles:definitions working_default_score.name
execute unless data storage reds_vehicles:definitions working_default_score.precision store result score vehicle.retrieved_precision vehicle.local run function reds_vehicles:define/precision/lookup with storage reds_vehicles:definitions args
execute unless data storage reds_vehicles:definitions working_default_score.precision if score vehicle.retrieved_precision vehicle.local matches 0 run function reds_vehicles:define/default_score/report/precision_macro_fail
execute unless data storage reds_vehicles:definitions working_default_score.precision if score vehicle.retrieved_precision vehicle.local matches 0 run return run function reds_vehicles:define/default_score/exit_fail
execute unless data storage reds_vehicles:definitions working_default_score.precision store result storage reds_vehicles:definitions working_default_score.precision int 1 run scoreboard players get vehicle.retrieved_precision vehicle.local

# Convert "value" to integer using precision
execute store result score vehicle.precision_apply_status vehicle.local run function reds_vehicles:define/default_score/__precision with storage reds_vehicles:definitions working_default_score
execute if score vehicle.precision_apply_status vehicle.local matches 0 run function reds_vehicles:define/default_score/report/precision_apply_macro_fail
execute if score vehicle.precision_apply_status vehicle.local matches 0 run function reds_vehicles:define/default_score/exit_fail
data remove storage reds_vehicles:definitions working_default_score.precision

# Success!
return run function reds_vehicles:define/default_score/exit_success

