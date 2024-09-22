data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/event/parse"
data modify storage reds_vehicles:logging error.description set value {text:"Missing required \"actions\" field from event"}
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 45

function reds_vehicles:define/logging/log_auto_fill_name
