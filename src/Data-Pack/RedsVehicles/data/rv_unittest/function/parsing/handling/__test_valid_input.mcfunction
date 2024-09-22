#####################################################################################################
# Setup - GROUP.INPUT
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset
$data modify storage reds_vehicles:definitions working_handling set value {input: "$(group).$(input)", operation: "increase", variable: "vehicle.foobar"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/handling/parse

# Analyze and display results
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail
$execute unless data storage reds_vehicles:definitions working_handling{input_group: "$(group)"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_handling.input_group to be \"$(group)\" (was "},{nbt:"working_handling.input_group", storage:"reds_vehicles:definitions"},{text:")"}]
$execute unless data storage reds_vehicles:definitions working_handling{input_group: "$(group)"} run return run function rv_unittest:common/fail

return 1
#####################################################################################################
