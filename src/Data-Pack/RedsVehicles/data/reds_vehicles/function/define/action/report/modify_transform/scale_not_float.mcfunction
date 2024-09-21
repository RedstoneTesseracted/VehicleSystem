data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/action/type/modify_transform"
data modify storage reds_vehicles:logging error.description set value {text:"Field \"scale\" for action type \"modify_transform\" might not be a float (possibly a double?).  See Extra for current value of \"scale\""}
data modify storage reds_vehicles:logging error.extra set from storage reds_vehicles:definitions working_action.arguments.scale

function reds_vehicles:define/logging/log_auto_fill_name
