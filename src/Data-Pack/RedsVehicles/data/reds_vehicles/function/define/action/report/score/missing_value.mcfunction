data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/action/type/set_score"
data modify storage reds_vehicles:logging error.description set value {text:"Action type \"set_score\" missing required field \"value\""}
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 20

function reds_vehicles:define/logging/log_auto_fill_name
