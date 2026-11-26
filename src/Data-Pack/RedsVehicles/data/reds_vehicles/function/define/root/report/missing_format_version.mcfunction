data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/root/parse"
data modify storage reds_vehicles:logging error.description set value {text:"Vehicle missing required \"format_version\" field"}
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 68

function reds_vehicles:define/logging/log_auto_fill_name
