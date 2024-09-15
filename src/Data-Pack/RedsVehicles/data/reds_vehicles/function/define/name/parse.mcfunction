# Function used by reds_vehicles:define/root/parse to validate the vehicle name
#
# Returns a "0" on failure, and a "1" on success

# Assert name tag existence
execute unless data storage reds_vehicles:definitions working_root.name run function reds_vehicles:define/name/report/missing
execute unless data storage reds_vehicles:definitions working_root.name run return 0

# Assert nonzero name length
execute store result score vehicle.name_length vehicle.local run data get storage reds_vehicles:definitions working_root.name
execute unless score vehicle.name_length vehicle.local matches 1.. run function reds_vehicles:define/name/report/zero_length
execute unless score vehicle.name_length vehicle.local matches 1.. run return run function reds_vehicles:define/name/exit_fail

# Assert name is a string
data modify storage red_vehicles:types check set from storage reds_vehicles:definitions working_root.name
execute store result score vehicle.name_is_string vehicle.local run function reds_vehicles:util/typing/is_string
execute if score vehicle.name_is_string vehicle.local matches 0 run function reds_vehicles:define/name/report/wrong_type
execute if score vehicle.name_is_string vehicle.local matches 0 run function reds_vehicles:define/name/exit_fail

# Assert that name doesn't conflict with ANY registered name
# Also, it should be able to work with a function macro
data modify storage reds_vehicles:definitions args.name set from storage reds_vehicles:definitions working_root.name
execute store result score vehicle.vehicle_exists vehicle.local run function reds_vehicles:define/name/check_registered_name with storage reds_vehicles:definitions working_root

execute if score vehicle.vehicle_exists vehicle.local matches 1 run function reds_vehicles:define/name/report/taken
execute if score vehicle.vehicle_exists vehicle.local matches 0 run function reds_vehicles:define/name/report/invalid
execute unless score vehicle.vehicle_exists vehicle.local matches -1 run return run function reds_vehicles:define/name/exit_fail

# Everything passed!
return run function reds_vehicles:define/name/exit_success
