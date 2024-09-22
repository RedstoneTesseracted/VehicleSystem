data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/action/type/set_rotation_axis_angle"
data modify storage reds_vehicles:logging error.description set value {text:"Action type \"set_rotation_axis_angle\" missing one of required fields \"name\" or \"group\""}
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 24

function reds_vehicles:define/logging/log_auto_fill_name
