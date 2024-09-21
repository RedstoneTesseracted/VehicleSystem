data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/action/type/set_rotation_axis_angle"
data modify storage reds_vehicles:logging error.description set value {text:"Field \"scale\" for action type \"set_rotation_axis_angle\" might not be a float (possibly a double?).  See Extra for current value of \"scale\""}
data modify storage reds_vehicles:logging error.extra set from storage reds_vehicles:definitions working_action.arguments.scale

function reds_vehicles:define/logging/log_auto_fill_name
