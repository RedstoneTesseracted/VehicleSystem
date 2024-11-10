#### UNIT TEST ####
data modify storage reds_vehicles:unittest name set value "parsing/handling/test_invalid_input"
data modify storage reds_vehicles:unittest description set value {text:"Make sure we can catch invalid input when trying to declare an handling"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - INPUT MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_handling set value {operation: "increase", scale: {source: "constant",value:2.1f}, variable: "vehicle.dvel.x"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/handling/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"input\" is invalid"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 49}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 49"}]
execute unless data storage reds_vehicles:logging errors[{code: 49}] run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - OPERATION MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_handling set value {input: "look.x", scale: {source: "constant",value:2.1f}, variable: "vehicle.dvel.x"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/handling/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"operation\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 50}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 50"}]
execute unless data storage reds_vehicles:logging errors[{code: 50}] run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - VARIABLE MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_handling set value {input: "look.x", operation: "increase", scale: {source: "constant",value:2.1f}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/handling/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"variable\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 52}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 52"}]
execute unless data storage reds_vehicles:logging errors[{code: 52}] run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - INVALID INPUT
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_handling set value {input: "foo.bar", operation: "increase", scale: {source: "constant",value:2.1f}, variable: "vehicle.dvel.x"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/handling/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"input\" is invalid"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 74}] run data modify storage reds_vehicles:unittest reason set value {text:"Expected error code to be 74"}
execute unless data storage reds_vehicles:logging errors[{code: 74}] run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - INVALID OPERATION
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_handling set value {input: "look.x", operation: "notarealoperation", scale: {source: "constant",value:2.1f}, variable: "vehicle.dvel.x"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/handling/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"operation\" is invalid"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 83}] run data modify storage reds_vehicles:unittest reason set value {text:"Expected error code to be 83"}
execute unless data storage reds_vehicles:logging errors[{code: 83}] run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - CLAMPED_INCREASE MISSING MAX
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_handling set value {input: "look.x", operation: "clamped_increase", min: 0, scale: {source: "constant",value:2.1f}, variable: "vehicle.dvel.x"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/handling/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"max\" is missing and operation is \"clamped_increase\""}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 82}] run data modify storage reds_vehicles:unittest reason set value {text:"Expected error code to be 82"}
execute unless data storage reds_vehicles:logging errors[{code: 82}] run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - CLAMPED_INCREASE MISSING MIN
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_handling set value {input: "look.x", operation: "clamped_increase", max: 1000, scale: {source: "constant",value:2.1f}, variable: "vehicle.dvel.x"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/handling/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"min\" is missing and operation is \"clamped_increase\""}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 81}] run data modify storage reds_vehicles:unittest reason set value {text:"Expected error code to be 81"}
execute unless data storage reds_vehicles:logging errors[{code: 81}] run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - CLAMPED_DECREASE MISSING MAX
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_handling set value {input: "look.x", operation: "clamped_decrease", min: 0, scale: {source: "constant",value:2.1f}, variable: "vehicle.dvel.x"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/handling/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"max\" is missing and operation is \"clamped_decrease\""}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 82}] run data modify storage reds_vehicles:unittest reason set value {text:"Expected error code to be 82"}
execute unless data storage reds_vehicles:logging errors[{code: 82}] run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - CLAMPED_DECREASE MISSING MIN
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_handling set value {input: "look.x", operation: "clamped_decrease", max: 1000, scale: {source: "constant",value:2.1f}, variable: "vehicle.dvel.x"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/handling/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"min\" is missing and operation is \"clamped_decrease\""}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 81}] run data modify storage reds_vehicles:unittest reason set value {text:"Expected error code to be 81"}
execute unless data storage reds_vehicles:logging errors[{code: 81}] run return run function rv_unittest:common/fail


#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
