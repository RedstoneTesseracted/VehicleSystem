#### UNIT TEST ####
# Try to declare an action without providing any arguments
data modify storage reds_vehicles:unittest name set value "parsing/action/test_arguments_missing"
data modify storage reds_vehicles:unittest description set value {text:"Make sure we can catch an action not being given ANY arguments"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - ALL ARGUMENTS MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "effect_passenger"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when all arguments are missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 37}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 37 (arguments missing)"}]
execute unless data storage reds_vehicles:logging errors[{code: 37}] run return run function rv_unittest:common/fail


#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
