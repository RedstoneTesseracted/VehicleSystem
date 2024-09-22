#### UNIT TEST ####
data modify storage reds_vehicles:unittest name set value "parsing/predicate_list/test_valid_input"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare a predicate list"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - FULL
data merge storage reds_vehicles:definitions {vehicles:[],processed:[],working_predicate:""}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_predicates set value ["reds_vehicles:a","reds_vehicles:b","reds_vehicles:c"]

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/predicate_list/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions {working_predicate:"if predicate reds_vehicles:a if predicate reds_vehicles:b if predicate reds_vehicles:c "} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_predicate to be \"if predicate reds_vehicles:a if predicate reds_vehicles:b if predicate reds_vehicles:c \" (was "},{nbt:"working_predicate", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions {working_predicate:"if predicate reds_vehicles:a if predicate reds_vehicles:b if predicate reds_vehicles:c "} run return run function rv_unittest:common/fail

#####################################################################################################



# Everything passed!
return run function rv_unittest:common/pass
