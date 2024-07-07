# This function checks that name tag exists and does not conflict with any already registered names
# It is called from reds_vehicles:define/process_loop

scoreboard players set vehicle.asserted_local vehicle.local 0

# Get name length
execute store result score vehicle.name_length vehicle.local run data get storage reds_vehicles:definitions working.name

# Assert existence and nonzero length
execute unless data storage reds_vehicles:definitions working.name run function reds_vehicles:define/assert_fail {vehicle:"<missing>", source: "reds_vehicles:define/assert_name", description: '[{"text":"Vehicle is missing required field "},{"text":"name","underlined":true,"color":"yellow"}]'}
execute if data storage reds_vehicles:definitions working.name if score vehicle.name_length vehicle.local matches 0 run function reds_vehicles:define/assert_fail {vehicle:"<zero-length>", source: "reds_vehicles:define/assert_name", description: '[{"text":"Vehicle has a zero-length name"}]'}


# Assert that name doesn't conflict with ANY registered name
data modify storage reds_vehicles:definitions args.name set from storage reds_vehicles:definitions working.name
scoreboard players set vehicle.ok_flag vehicle.local 0
execute store result score vehicle.vehicle_exists vehicle.local run function reds_vehicles:define/__assert_name with storage reds_vehicles:definitions args
data remove storage reds_vehicles:definitions args.name

data merge storage reds_vehicles:definitions {args:{source: "reds_vehicles:define/assert_name", description: '[{"text":"Name conflicts with already registered vehicle"}]'}}
data modify storage reds_vehicles:definitions args.vehicle set from storage reds_vehicles:definitions working.name
execute if score vehicle.vehicle_exists vehicle.local matches 1 run function reds_vehicles:define/assert_fail with storage reds_vehicles:definitions args
data remove storage reds_vehicles:definitions args

# Check if the lookup function broke (if it ran, we should see vehicle.ok_flag=1)
execute if score vehicle.ok_flag vehicle.local matches 0 run function reds_vehicles:define/assert_fail {vehicle:"<error>", source: "reds_vehicles:define/assert_name", description: '[{"text":"An unknown error occured while looking up vehicle name with reds_vehicles:define/__assert_name, as the function macro did not compile"}]'}

# Set name to fallback <error> if assertion failed
execute unless score vehicle.asserted_local vehicle.local matches 0 run data modify storage reds_vehicles:definitions working.name set value '<error>'


# Reset temporary scores
scoreboard players reset vehicle.asserted_local vehicle.local
scoreboard players reset vehicle.name_length vehicle.local
scoreboard players reset vehicle.vehicle_exists vehicle.local
scoreboard players reset vehicle.ok_flag vehicle.local

