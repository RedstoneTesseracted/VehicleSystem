data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/action/type/modify_transform"
data modify storage reds_vehicles:logging error.description set value {text:"Action type \"modify_transform\" missing one of required fields \"name\" or \"group\""}

function reds_vehicles:define/logging/log_auto_fill_name
