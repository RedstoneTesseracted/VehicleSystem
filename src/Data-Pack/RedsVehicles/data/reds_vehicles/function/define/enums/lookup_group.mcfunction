# This function looks up a provided key in the provided enum table and returns the group name
# The result is stored in reds_vehicles:definitions under returned_group
#
# The key and enum table are provided using function macros
#
# This is intended for obtaining input groups

# We use this line to check that this function compiled and ran
scoreboard players set vehicle.ok_flag vehicle.local 1
scoreboard players reset vehicle.result vehicle.local
$data modify storage reds_vehicles:definitions returned_group set from storage reds_vehicles:enums $(table)[{type:"$(key)"}].group

return 1
