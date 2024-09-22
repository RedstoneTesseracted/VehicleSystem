data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/default_score/parse"
data modify storage reds_vehicles:logging error.description set value {text:"Default score setter missing required field \"name\""}
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 40

function reds_vehicles:define/logging/log_auto_fill_name
