# "constant" source type
#   Requires "value" field

scoreboard players set vehicle.source_type_exists vehicle.local 1
execute unless data storage reds_vehicles:definitions working_scale.value run function reds_vehicles:define/scale/report/value_missing
execute unless data storage reds_vehicles:definitions working_scale.value run return fail

return 1
