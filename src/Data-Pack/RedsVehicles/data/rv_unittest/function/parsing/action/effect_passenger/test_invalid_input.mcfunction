#### UNIT TEST ####
data modify storage reds_vehicles:unittest name set value "parsing/action/effect_passenger/test_invalid_input"
data modify storage reds_vehicles:unittest description set value {text:"Make sure we can catch invalid input when trying to declare a effect_passenger action"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - NAME MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "effect_passenger", arguments: {duration:2,amplifier:23,hide_particles:1b}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"name\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 3}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 3"}]
execute unless data storage reds_vehicles:logging errors[{code: 3}] run return run function rv_unittest:common/fail

#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
