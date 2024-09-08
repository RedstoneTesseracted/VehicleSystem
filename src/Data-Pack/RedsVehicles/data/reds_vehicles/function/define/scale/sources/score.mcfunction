# "score" source type
#   Requires "name" field

execute unless data storage reds_vehicles:definitions working_scale.name run function reds_vehicles:define/scale/report/name_missing
execute unless data storage reds_vehicles:definitions working_scale.name run return -1

return 1
