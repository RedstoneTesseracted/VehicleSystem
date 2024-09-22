data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/part/parse"
data modify storage reds_vehicles:logging error.description set value {text:"Missing required \"item\" field in part tag"}
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 61

function reds_vehicles:define/logging/log_auto_fill_name
