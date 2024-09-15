# Logs the vehicle's name already being registered

# Set up and execute error logging call
data modify storage reds_vehicles:logging error.vehicle set value '"<invalid>"'
data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/name/parse"
data modify storage reds_vehicles:logging error.description set value [{text:"Name \""},{text: ""},{text:"\" conflicts with already registered vehicle"}]
data modify storage reds_vehicles:logging error.description[1].text set from storage reds_vehicles:definitions working_root.name

function reds_vehicles:define/logging/log_error
