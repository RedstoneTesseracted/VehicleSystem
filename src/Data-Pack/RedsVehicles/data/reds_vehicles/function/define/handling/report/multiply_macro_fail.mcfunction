data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/handling/parse"
data modify storage reds_vehicles:logging error.description set value {text:"An unknown error caused the function macro \"reds_vehicles:define/handling/util/min_max_mult_precision\" to fail to compile.  See Extra for the precision argument passed to the macro."}
data modify storage reds_vehicles:logging error.extra set from storage reds_vehicles:definitions working_handling.precision
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 88

function reds_vehicles:define/logging/log_auto_fill_name
