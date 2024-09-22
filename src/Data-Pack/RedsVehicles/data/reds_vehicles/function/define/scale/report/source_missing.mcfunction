data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/scale/parse"
data modify storage reds_vehicles:logging error.description set value {text:"Missing source field in scale tag"}
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 72

function reds_vehicles:define/logging/log_auto_fill_name
