# Mark operation as existing
scoreboard players set vehicle.operation_exists vehicle.local 1

# min/max fields required
execute unless data storage reds_vehicles:definitions working_handling.min run function reds_vehicles:define/handling/report/min_missing
execute unless data storage reds_vehicles:definitions working_handling.min run return 0
execute unless data storage reds_vehicles:definitions working_handling.max run function reds_vehicles:define/handling/report/max_missing
execute unless data storage reds_vehicles:definitions working_handling.max run return 0

# Multiply min/max fields by precision multiplier
scoreboard players set vehicle.multiply_macro_status vehicle.local -1
execute store result score vehicle.multiply_macro_status vehicle.local run function reds_vehicles:define/handling/util/min_max_mult_precision with storage reds_vehicles:definitions working_handling
execute if score vehicle.multiply_macro_status vehicle.local matches 0 run function reds_vehicles:define/handling/report/multiply_macro_fail
execute if score vehicle.multiply_macro_status vehicle.local matches 0 run return 0

# Success!
return 1
