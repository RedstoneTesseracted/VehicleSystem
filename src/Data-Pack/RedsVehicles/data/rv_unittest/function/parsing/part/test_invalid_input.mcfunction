#### UNIT TEST ####
data modify storage reds_vehicles:unittest name set value "parsing/part/test_invalid_input"
data modify storage reds_vehicles:unittest description set value {text:"Make sure we can catch invalid input when trying to declare an part"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - NAME MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_part set value {scale: [1.0f, 2.0f, 3.0f], translation: [4.0f, 5.0f, 6.0f], item: "minecraft:glass", model: "reds_vehicles:vehicles/test"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/part/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"input\" is invalid"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 62}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 62"}]
execute unless data storage reds_vehicles:logging errors[{code: 62}] run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - ITEM MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_part set value {name: "display", scale: [1.0f, 2.0f, 3.0f], translation: [4.0f, 5.0f, 6.0f], model: "reds_vehicles:vehicles/test"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/part/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"input\" is invalid"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 61}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 61"}]
execute unless data storage reds_vehicles:logging errors[{code: 61}] run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - BAD GROUP NAME
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_part set value {name: "display", groups: ["meep\"morp"], scale: [1.0f, 2.0f, 3.0f], translation: [4.0f, 5.0f, 6.0f], model: "reds_vehicles:vehicles/test"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/part/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"groups\" is invalid"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 86}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 86"}]
execute unless data storage reds_vehicles:logging errors[{code: 86}] run return run function rv_unittest:common/fail


#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
