#### UNIT TEST ####
# Try to declare a valid "effect_passenger" actions
data modify storage reds_vehicles:unittest name set value "parsing/event/test_invalid_input"
data modify storage reds_vehicles:unittest description set value {text:"Make sure we can catch invalid input when trying to declare an event"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - ACTION LIST MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_event set value {trigger: "vehicle.horn.honk"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/event/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"actions\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 45}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 45"}]
execute unless data storage reds_vehicles:logging errors[{code: 45}] run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - ACTION ZERO LENGTH
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_event set value {trigger: "vehicle.horn.honk", actions: []}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/event/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"actions\" is zero-length"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 47}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 47"}]
execute unless data storage reds_vehicles:logging errors[{code: 47}] run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - GARBLED TRIGGER
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_event set value {trigger: "\"vehicle.horn.honk\"", actions: [{action: "playsound", arguments: {sound:"minecraft:block.stone.break"}}]}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/event/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"trigger\" is garbled"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 46}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 46"}]
execute unless data storage reds_vehicles:logging errors[{code: 46}] run return run function rv_unittest:common/fail


#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
