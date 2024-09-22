data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/handling/parse"
data modify storage reds_vehicles:logging error.provided_input set from storage reds_vehicles:definitions working_handling.input
data modify storage reds_vehicles:logging error.description set value [{text:"\""},{nbt:"working_error.provided_input",storage:"reds_vehicles:logging"},{text:"\" is not a recognized input source"}]
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 74

function reds_vehicles:define/logging/log_auto_fill_name
