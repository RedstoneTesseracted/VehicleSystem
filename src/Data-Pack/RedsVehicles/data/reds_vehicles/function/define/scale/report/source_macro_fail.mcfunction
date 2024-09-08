# Source field missing

data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/scale/parse"
data modify storage reds_vehicles:logging error.description set value {text:"An unknown error caused the function macro reds_vehicles:define/scale/source_specific_validation to fail to compile.  Either the provided source type is invalid or there is a bug."}

function reds_vehicles:define/logging/log_auto_fill_name
