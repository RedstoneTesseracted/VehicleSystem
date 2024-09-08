# Logs the vehicle's name being absent

# Set up and execute error logging call
data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/handling_list/parse_loop"
data modify storage reds_vehicles:logging error.description set value {text:"An unknown error occured that caused the function macro in reds_vehicles:define/handling_list/mark_input_group to fail to compile"}

function reds_vehicles:define/logging/log_auto_fill_name
