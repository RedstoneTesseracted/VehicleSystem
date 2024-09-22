data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/action/type/effect_passenger"
data modify storage reds_vehicles:logging error.description set value {text:"Action type \"effect_passenger\" missing required field \"name\""}
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 3

function reds_vehicles:define/logging/log_auto_fill_name
