data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/action/type/modify_transform"
data modify storage reds_vehicles:logging error.description set value {text:"Action type \"modify_transform\" missing required field \"source\""}
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 8

function reds_vehicles:define/logging/log_auto_fill_name
