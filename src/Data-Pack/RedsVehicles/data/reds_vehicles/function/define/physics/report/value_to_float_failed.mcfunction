data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/physics/parse"
data modify storage reds_vehicles:logging error.description set value {text:"Failed to convert \"value\" to a float.  See Extra for \"value\" field"}
data modify storage reds_vehicles:logging error.extra set from storage reds_vehicles:definitions working_physics.value
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 80

function reds_vehicles:define/logging/log_auto_fill_name
