data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/handling/parse"
data modify storage reds_vehicles:logging error.description set value {text:"Missing operation field in handling tag"}
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 50

function reds_vehicles:define/logging/log_auto_fill_name
