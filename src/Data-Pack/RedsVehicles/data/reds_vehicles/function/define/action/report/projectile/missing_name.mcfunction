data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/action/type/projectile"
data modify storage reds_vehicles:logging error.description set value {text:"Action type \"projectile\" missing required field \"name\""}
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 16

function reds_vehicles:define/logging/log_auto_fill_name
