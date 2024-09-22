#### UNIT TEST ####
# Try to declare a valid "set_transform" actions
data modify storage reds_vehicles:unittest name set value "parsing/action/set_transform/test_invalid_input"
data modify storage reds_vehicles:unittest description set value {text:"Make sure we can catch invalid input when trying to declare a set_transform action"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - NAME & GROUP MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_transform", arguments: {transform:"left_rotation",parameter:{angle:45.0f,axis:[1.0f,0.0f,0.0f]}}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"name\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 33}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 33"}]
execute unless data storage reds_vehicles:logging errors[{code: 33}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - TRANSFORM MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_transform", arguments: {name:"display",parameter:{angle:45.0f,axis:[1.0f,0.0f,0.0f]}}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"transform\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 35}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 35"}]
execute unless data storage reds_vehicles:logging errors[{code: 35}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - PARAMETER MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_transform", arguments: {name:"display",transform:"left_rotation"}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"parameter\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 34}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 34"}]
execute unless data storage reds_vehicles:logging errors[{code: 34}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - NAME AND GROUP SPECIFIED
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_transform", arguments: {name:"display",group:"foobar",transform:"left_rotation",parameter:{angle:45.0f,axis:[1.0f,0.0f,0.0f]}}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"name\" AND \"group\" are provided"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 31}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 31"}]
execute unless data storage reds_vehicles:logging errors[{code: 31}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - GARBLED NAME
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_transform", arguments: {name:"\"foobar\"",transform:"left_rotation",parameter:{angle:45.0f,axis:[1.0f,0.0f,0.0f]}}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"name\" is garbled"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 36}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 36"}]
execute unless data storage reds_vehicles:logging errors[{code: 36}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - GARBLED GROUP
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_transform", arguments: {group:"\"foobar\"",transform:"left_rotation",parameter:{angle:45.0f,axis:[1.0f,0.0f,0.0f]}}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"group\" is garbled"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 32}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 32"}]
execute unless data storage reds_vehicles:logging errors[{code: 32}] run return run function rv_unittest:common/fail

#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
