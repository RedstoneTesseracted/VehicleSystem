data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/action/type/set_rotation_axis_angle"
data modify storage reds_vehicles:logging error.axis_value set from storage reds_vehicles:definitions working_action.arguments.axis
data modify storage reds_vehicles:logging error.description set value [{text:"Action type \"set_rotation_axis_angle\" expects an array of length 3 for field \"axis\".  Instead received: "},{nbt: "working_error.axis_value",storage:"reds_vehicles:logging"}]

function reds_vehicles:define/logging/log_auto_fill_name
