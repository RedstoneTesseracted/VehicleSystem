data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/action/type/relative_particle"
data modify storage reds_vehicles:logging error.description set value {text:"Action type \"relative_particle\" missing required field \"name\""}
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 17

function reds_vehicles:define/logging/log_auto_fill_name
