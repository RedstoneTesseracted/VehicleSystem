data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/part/group_prepend_loop"
data modify storage reds_vehicles:logging error.description set value {text:"An unknown error occurred that caused the function macro in reds_vehicles:define/part/__group_prepend_loop to fail.  See Extra for the string that was passed to this macro."}
data modify storage reds_vehicles:definitions error.extra set from storage reds_vehicles:definitions args.string
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 86

function reds_vehicles:define/logging/log_auto_fill_name
