# "score" source type
#   Requires "name" field

scoreboard players set vehicle.source_type_exists vehicle.local 1
execute unless data storage reds_vehicles:definitions working_scale.name run function reds_vehicles:define/scale/report/name_missing
execute unless data storage reds_vehicles:definitions working_scale.name run return fail

return 1
