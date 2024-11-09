data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/action/parse"
data modify storage reds_vehicles:logging error.description set value {text:"Missing required \"arguments\" field from action"}
data modify storage reds_vehicles:logging error.extra set from storage reds_vehicles:definitions working_action
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 37

function reds_vehicles:define/logging/log_auto_fill_name
