# "constant" source type
#   Requires "value" field

execute unless data storage reds_vehicles:definitions working_scale.value run function reds_vehicles:define/scale/report/value_missing
execute unless data storage reds_vehicles:definitions working_scale.value run return -1

return 1
