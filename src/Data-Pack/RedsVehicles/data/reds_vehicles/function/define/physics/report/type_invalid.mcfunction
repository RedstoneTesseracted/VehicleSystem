# Input field missing

data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/physics/parse"
data modify storage reds_vehicles:logging error.description set value [{text:"\""},{text: ""},{text:"\" is not a recognized physics type"}]
data modify storage reds_vehicles:logging error.description[1].text set from storage reds_vehicles:definitions working_physics.type

function reds_vehicles:define/logging/log_auto_fill_name
