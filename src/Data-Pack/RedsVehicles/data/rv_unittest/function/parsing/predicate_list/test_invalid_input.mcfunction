#### UNIT TEST ####
data modify storage reds_vehicles:unittest name set value "parsing/predicate_list/test_invalid_input"
data modify storage reds_vehicles:unittest description set value {text:"Make sure we can catch invalid input when trying to declare a predicate list"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - GARBLED
data merge storage reds_vehicles:definitions {vehicles:[],processed:[],working_predicate:""}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_predicates set value ["\"reds_vehicles:a","reds_vehicles:b","\"reds_vehicles:c"]

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/predicate_list/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"input\" is invalid"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 67}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 67"}]
execute unless data storage reds_vehicles:logging errors[{code: 67}] run return run function rv_unittest:common/fail


#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
