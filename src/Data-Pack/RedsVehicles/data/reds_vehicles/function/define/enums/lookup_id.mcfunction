# This function looks up a provided key in the provided enum table and returns the resulting id
#
# The key and enum table are provided using function macros
#
#

# We use this line to check that this function compiled and ran
scoreboard players reset vehicle.result vehicle.local
$execute store result score vehicle.result vehicle.local run data get storage reds_vehicles:enums $(table)[{type:"$(key)"}].id

# Return -1 if lookup failed (lookup returned 0)
execute if score vehicle.result vehicle.local matches 0 run return -1
return run scoreboard players get vehicle.result vehicle.local

