#### UNIT TEST ####
# Try to declare a valid "playsound" actions
data modify storage reds_vehicles:unittest name set value "parsing/action/playsound/test_invalid_input"
data modify storage reds_vehicles:unittest description set value {text:"Make sure we can catch invalid input when trying to declare a playsound action"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - SOUND MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "playsound", arguments: {pitch:4.5,volume:2.1}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"sound\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 14}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 14"}]
execute unless data storage reds_vehicles:logging errors[{code: 14}] run return run function rv_unittest:common/fail

#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
