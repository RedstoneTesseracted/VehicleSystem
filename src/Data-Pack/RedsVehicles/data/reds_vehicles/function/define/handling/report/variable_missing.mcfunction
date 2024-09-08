# Variable field missing

# Set up and execute error logging call
data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/handling/parse"
data modify storage reds_vehicles:logging error.description set value {text:"Missing variable field in handling tag"}

function reds_vehicles:define/logging/log_auto_fill_name
