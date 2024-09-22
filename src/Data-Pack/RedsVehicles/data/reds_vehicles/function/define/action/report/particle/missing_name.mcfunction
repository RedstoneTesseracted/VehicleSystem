data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/action/type/particle"
data modify storage reds_vehicles:logging error.description set value {text:"Action type \"particle\" missing required field \"name\""}
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 13

function reds_vehicles:define/logging/log_auto_fill_name
