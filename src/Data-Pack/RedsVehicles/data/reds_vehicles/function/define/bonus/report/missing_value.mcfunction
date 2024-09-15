data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/bonus/parse"
data modify storage reds_vehicles:logging error.description set value {text:"Missing required \"value\" field from bonus"}

function reds_vehicles:define/logging/log_auto_fill_name
