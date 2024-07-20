# This function grabs the requested vehicle's definition from the global
# definition table and stores it in reds_vehicles:definitions.current
#
#
# The name of the vehicle is provided via function macros

$data modify storage reds_vehicles:definitions current set from storage reds_vehicles:definitions processed[{name:$(name)}]
