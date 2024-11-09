data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/action/type/message"
data modify storage reds_vehicles:logging error.description set value {text:"Action type \"message\" missing required field \"text\""}
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 77

function reds_vehicles:define/logging/log_auto_fill_name
