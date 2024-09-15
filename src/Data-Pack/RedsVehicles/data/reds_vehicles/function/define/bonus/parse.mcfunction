# This function is used to parse/validate a single bonus tag
# The bonus tag to parse/validate must be at "working_bonus"
# under the "reds_vehicles:definitions" storage
#
# The input tag is modified in-place
#
# Return 1 = Passed
# Return 0 = Failed
#

# Type field is required
execute unless data storage reds_vehicles:definitions working_bonus.type run function reds_vehicles:define/bonus/report/missing_type
execute unless data storage reds_vehicles:definitions working_bonus.type run function reds_vehicles:define/bonus/exit_fail

# Value field is required
execute unless data storage reds_vehicles:definitions working_bonus.value run function reds_vehicles:define/bonus/report/missing_value
execute unless data storage reds_vehicles:definitions working_bonus.value run function reds_vehicles:define/bonus/exit_fail

# Predicates field is optional
execute unless data storage reds_vehicles:definitions working_bonus.predicates run data modify storage reds_vehicles:definitions working_bonus.predicate set value ""
execute if data storage reds_vehicles:definitions working_bonus.predicates run data modify storage reds_vehicles:definitions working_predicate_list set from storage reds_vehicles:definitions working_bonus.predicates
execute if data storage reds_vehicles:definitions working_bonus.predicates unless function reds_vehicles:define/predicate_list/parse run return run function reds_vehicles:define/bonus/exit_fail
data remove storage reds_vehicles:definitions working_bonus.predicates


# Attempt to run corresponding type validation
scoreboard players set vehicle.bonus_exists vehicle.local 0
execute store result score vehicle.bonus_type_status vehicle.local run function reds_vehicles:define/bonus/parse_type_specific with storage reds_vehicles:definitions working_bonus

# Handle validation failure
execute if score vehicle.bonus_type_status vehicle.local matches 0 run function reds_vehicles:define/bonus/report/type_macro_fail
execute if score vehicle.bonus_type_status vehicle.local matches 0 run function reds_vehicles:define/bonus/exit_fail

execute if score vehicle.bonus_exists vehicle.local matches 0 run function reds_vehicles:define/bonus/report/unknown_bonus
execute if score vehicle.bonus_exists vehicle.local matches 0 run function reds_vehicles:define/bonus/exit_fail

execute if score vehicle.bonus_type_status vehicle.local matches -1 run return run function reds_vehicles:define/bonus/exit_fail


# Success!
return run function reds_vehicles:define/bonus/exit_success

