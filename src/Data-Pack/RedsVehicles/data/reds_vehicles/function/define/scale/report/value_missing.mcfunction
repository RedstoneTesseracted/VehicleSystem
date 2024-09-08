# Source field missing

data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/scale/sources/constant"
data modify storage reds_vehicles:logging error.description set value {text:"Missing required \"value\" field for source type \"constant\""}

function reds_vehicles:define/logging/log_auto_fill_name
