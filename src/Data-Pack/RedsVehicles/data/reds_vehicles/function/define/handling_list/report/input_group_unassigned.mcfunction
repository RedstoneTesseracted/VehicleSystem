# Logs the vehicle's name being absent

# Set up and execute error logging call
data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/handling_list/parse_loop"
data modify storage reds_vehicles:logging error.description set value {text:"An internal error occurred that caused that prevented a handling tag's input group from being assigned.  This is likely a bug with the pack.  See Extra for handling tag in question."}
data modify storage reds_vehicles:logging error.extra set from storage reds_vehicles:definitions working_handling

function reds_vehicles:define/logging/log_auto_fill_name
