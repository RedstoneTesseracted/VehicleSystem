#### UNIT TEST ####
# Try to declare an action that doesn't exist
data modify storage reds_vehicles:unittest name set value "parsing/action/test_unknown_action"
data modify storage reds_vehicles:unittest description set value {text:"Make sure we can catch an unknown action"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - ALL ARGUMENTS MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "notarealaction", arguments: {foo: "bar"}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed for unknown action"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 39}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 39 (unknown action)"}]
execute unless data storage reds_vehicles:logging errors[{code: 39}] run return run function rv_unittest:common/fail


#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
