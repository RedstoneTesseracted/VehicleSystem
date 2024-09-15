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

# Success!
return run function reds_vehicles:define/default_score/exit_success

