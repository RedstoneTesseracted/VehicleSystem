#### UNIT TEST ####
# Try to declare a valid "effect_passenger" actions
data modify storage reds_vehicles:unittest name set value "parsing/name/test_valid_input"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare an name element using valid input"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - FULL
data merge storage reds_vehicles:definitions {vehicles:[],processed:[],working_root:{}}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_root.name set value "foobar"

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/name/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_root{name: "foobar"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_root.name to be \"foobar\" (was "},{nbt:"working_handling.precision", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{name: "foobar"} run return run function rv_unittest:common/fail


#####################################################################################################


# Everything passed!
return run function rv_unittest:common/pass
