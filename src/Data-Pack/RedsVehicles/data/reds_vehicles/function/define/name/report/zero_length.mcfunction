# Logs the vehicle's name being absent

# Set up and execute error logging call
data modify storage reds_vehicles:logging error.vehicle set value '"<zero-length>"'
data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/name/parse"
data modify storage reds_vehicles:logging error.description set value {"text":"Vehicle has a zero-length name"}

function reds_vehicles:define/logging/log_error
