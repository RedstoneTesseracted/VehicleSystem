data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/action/type/relative_particle"
data modify storage reds_vehicles:logging error.description set value {text:"Action type \"relative_particle\" missing required field \"name\""}

function reds_vehicles:define/logging/log_auto_fill_name
