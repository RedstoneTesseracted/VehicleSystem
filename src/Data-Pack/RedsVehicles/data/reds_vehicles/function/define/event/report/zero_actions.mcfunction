# reds_vehicles:define/event/generate_trigger_condition macro failed

data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/event/parse"
data modify storage reds_vehicles:logging error.description set value {text:"Event tag's actions list must have nonzero length"}

function reds_vehicles:define/logging/log_auto_fill_name
