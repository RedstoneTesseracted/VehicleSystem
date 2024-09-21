data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/action/type/set_transform"
data modify storage reds_vehicles:logging error.description set value {text:"Action type \"set_transform\" missing required field \"parameter\""}

function reds_vehicles:define/logging/log_auto_fill_name
