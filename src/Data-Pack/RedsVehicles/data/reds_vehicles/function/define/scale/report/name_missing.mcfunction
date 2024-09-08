# Source field missing

data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/scale/sources/score"
data modify storage reds_vehicles:logging error.description set value {text:"Missing required \"name\" field for source type source \"name\""}

function reds_vehicles:define/logging/log_auto_fill_name
