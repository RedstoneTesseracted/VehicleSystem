data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/handling_list/parse"
data modify storage reds_vehicles:logging error.description set value {text:"An unknown error caused the function macro \"reds_vehicles:define/handling_list/__mark_input_group\" to fail to compile.  This is likely a bug in the pack.  See Extra the arguments passed to the macro."}
data modify storage reds_vehicles:logging error.extra set from storage reds_vehicles:definitions working_handling

function reds_vehicles:define/logging/log_auto_fill_name
