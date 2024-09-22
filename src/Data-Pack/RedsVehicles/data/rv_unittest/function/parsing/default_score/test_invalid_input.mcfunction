#### UNIT TEST ####
# Try to declare a valid "effect_passenger" actions
data modify storage reds_vehicles:unittest name set value "parsing/default_score/test_invalid_input"
data modify storage reds_vehicles:unittest description set value {text:"Make sure we can catch invalid input when trying to declare a default_score element"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - NAME MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_default_score set value {value: 0.5}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/default_score/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"name\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 40}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 40"}]
execute unless data storage reds_vehicles:logging errors[{code: 40}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - VALUE MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_default_score set value {name: "vehicle.thrust"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/default_score/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"name\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 41}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 41"}]
execute unless data storage reds_vehicles:logging errors[{code: 41}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - GARBLED PRECISION
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_default_score set value {name: "vehicle.nonstandard", value: 0.5, precision: "foobar"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/default_score/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"precision\" is garbled"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 42}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 42"}]
execute unless data storage reds_vehicles:logging errors[{code: 42}] run return run function rv_unittest:common/fail

#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
