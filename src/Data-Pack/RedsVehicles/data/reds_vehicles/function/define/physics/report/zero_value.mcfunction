data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/physics/parse"
data modify storage reds_vehicles:logging error.description set value [{text:"\"value\" field cannot be zero for force type \""},{text:""},{text:"\""}]
data modify storage reds_vehicles:logging error.description[1].text set from storage reds_vehicles:definitions working_physics.type
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 78

function reds_vehicles:define/logging/log_auto_fill_name
