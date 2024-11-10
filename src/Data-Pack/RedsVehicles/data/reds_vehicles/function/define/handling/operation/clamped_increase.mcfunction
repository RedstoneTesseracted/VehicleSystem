# Mark operation as existing
scoreboard players set vehicle.operation_exists vehicle.local 1

# min/max fields required
execute unless data storage reds_vehicles:definitions working_handling.min run function reds_vehicles:define/handling/report/min_missing
execute unless data storage reds_vehicles:definitions working_handling.min run return 0
execute unless data storage reds_vehicles:definitions working_handling.max run function reds_vehicles:define/handling/report/max_missing
execute unless data storage reds_vehicles:definitions working_handling.max run return 0

# Success!
return 1
