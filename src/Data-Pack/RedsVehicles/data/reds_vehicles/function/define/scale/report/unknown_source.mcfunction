data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/scale/parse"
data modify storage reds_vehicles:logging error.source_type set from storage reds_vehicles:definitions working_scale.source
data modify storage reds_vehicles:logging error.description set value [{text:"\""},{nbt:"working_error.source_type",storage:"reds_vehicles:logging"},{text:"\" is not a recognized source type"}]
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 75

function reds_vehicles:define/logging/log_auto_fill_name
