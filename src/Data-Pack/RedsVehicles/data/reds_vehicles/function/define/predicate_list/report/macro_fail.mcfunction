data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/predicate_list/parse_loop"
data modify storage reds_vehicles:logging error.description set value {text:"An unknown error caused the function macro \"reds_vehicles:define/predicate_list/__parse_loop\" to fail to compile.  Either the predicate name string is invalid or there is a bug in the pack."}
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 67

function reds_vehicles:define/logging/log_auto_fill_name
