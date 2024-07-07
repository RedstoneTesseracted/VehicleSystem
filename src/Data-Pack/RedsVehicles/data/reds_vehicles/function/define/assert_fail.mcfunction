# Generic function for appending to the error log and setting the error flag
# vehicle, description, and source must be provided via function macros

scoreboard players set vehicle.error vehicle.local 1
scoreboard players set vehicle.asserted_local vehicle.local 1
$data modify storage reds_vehicles:definitions errors append value {vehicle: '$(vehicle)', description: '$(description)', source: '$(source)'}
