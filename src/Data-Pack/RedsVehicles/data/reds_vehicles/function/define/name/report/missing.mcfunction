# Logs the vehicle's name being absent

# Set up and execute error logging call
data modify storage reds_vehicles:logging error.vehicle set value "<missing>"
data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/name/parse"
data modify storage reds_vehicles:logging error.description set value [{text:"Vehicle is missing required field "},{text:"name",underlined:1b,color:"yellow"}]

function reds_vehicles:define/logging/log_error
