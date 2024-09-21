data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/action/type/projectile"
data modify storage reds_vehicles:logging error.description set value {text:"Action type \"projectile\" missing required field \"name\""}

function reds_vehicles:define/logging/log_auto_fill_name
