data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/physics/parse"
data modify storage reds_vehicles:logging error.description set value {text:"An unknown error occurred that caused the macro in reds_vehicles:define/physics/utility/__inverse_value to fail to compile.  This should not occur and may be a bug in the datapack.  See Extra for the value that was passed to the macro"}
data modify storage reds_vehicles:logging error.extra set from storage reds_vehicles:definitions working_physics.value
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 79

function reds_vehicles:define/logging/log_auto_fill_name
