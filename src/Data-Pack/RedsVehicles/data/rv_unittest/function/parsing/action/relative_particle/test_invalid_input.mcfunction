#### UNIT TEST ####
# Try to declare a valid "relative_particle" actions
data modify storage reds_vehicles:unittest name set value "parsing/action/relative_particle/test_invalid_input"
data modify storage reds_vehicles:unittest description set value {text:"Make sure we can catch invalid input when trying to declare a relative_particle action"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - NAME MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "relative_particle", arguments: {relative_to: "display", offset:[1.0,2.0,3.0],delta:[4.0,5.0,6.0],count:20,speed:0.1}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"name\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 17}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 17"}]
execute unless data storage reds_vehicles:logging errors[{code: 17}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - RELATIVE_TO MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "relative_particle", arguments: {name: "minecraft:bubble", offset:[1.0,2.0,3.0],delta:[4.0,5.0,6.0],count:20,speed:0.1}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when all \"relative_to\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 18}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 18"}]
execute unless data storage reds_vehicles:logging errors[{code: 18}] run return run function rv_unittest:common/fail

#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
