data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/handling/parse"
data modify storage reds_vehicles:logging error.provided_operation set from storage reds_vehicles:definitions working_handling.operation
data modify storage reds_vehicles:logging error.description set value [{text:"\""},{nbt:"working_error.provided_operation",storage:"reds_vehicles:logging"},{text:"\" is not a recognized operation type"}]
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 83

function reds_vehicles:define/logging/log_auto_fill_name
