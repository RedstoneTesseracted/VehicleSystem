data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/handling/parse"
data modify storage reds_vehicles:logging error.description set value {text:"An unknown error caused the function macro \"reds_vehicles:define/handling/parse_input_specific\" to fail to compile.  Either the given input type is invalid or there is a bug in the pack."}

function reds_vehicles:define/logging/log_auto_fill_name
