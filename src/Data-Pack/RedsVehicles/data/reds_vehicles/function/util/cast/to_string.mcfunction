# This function attempts to cast the provided value to a string via a function macro.
# Returns 0 on failure, and 1 on success.
#
# Value must be provided by setting the "check" tag in the 
# reds_vehicles:types storage
#
# The result is written back to the same tag
#

data modify storage reds_vehicles:types compare set value {value: ""}
data modify storage reds_vehicles:types compare.value set from storage reds_vehicles:types check
scoreboard players set vehicle.result vehicle.local 0
function reds_vehicles:util/cast/__to_string with storage reds_vehicles:types compare
data remove storage reds_vehicles:types compare
return run scoreboard players get vehicle.result vehicle.local
