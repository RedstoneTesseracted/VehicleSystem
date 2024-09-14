# Logs the vehicle's name being absent

# Set up and execute error logging call
data modify storage reds_vehicles:logging error.vehicle set value "<error>"
data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/name/parse"
data modify storage reds_vehicles:logging error.description set value [{text:"An unknown error occured while looking up vehicle name with reds_vehicles:define/name/check_registered_name, as the function macro did not compile.  See Extra for name being looked up."}]
data modify storage reds_vehicles:logging error.extra set from storage reds_vehicles:definitions working_root.name

function reds_vehicles:define/logging/log_error
