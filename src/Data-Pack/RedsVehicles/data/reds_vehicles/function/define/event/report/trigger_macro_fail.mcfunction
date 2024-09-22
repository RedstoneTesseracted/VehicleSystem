data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/event/parse"
data modify storage reds_vehicles:logging error.description set value {text:"An unknown error caused the function macro \"reds_vehicles:define/event/generate_trigger_condition\" to fail to compile.  Either the provided trigger score is invalid or there is a bug in the pack."}
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 46

function reds_vehicles:define/logging/log_auto_fill_name
