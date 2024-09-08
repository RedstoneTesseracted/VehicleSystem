# Input field missing

data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/physics/parse"
data modify storage reds_vehicles:logging error.description set value {text:"Missing type field in physics tag"}

function reds_vehicles:define/logging/log_auto_fill_name
