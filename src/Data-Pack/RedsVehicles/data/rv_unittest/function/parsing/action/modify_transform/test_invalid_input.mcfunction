#### UNIT TEST ####
# Try to declare a valid "modify_transform" actions
data modify storage reds_vehicles:unittest name set value "parsing/action/modify_transform/test_invalid_input"
data modify storage reds_vehicles:unittest description set value {text:"Make sure we can catch invalid input when trying to declare a modify_transform action"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - NAME & GROUP MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "modify_transform", arguments: {transform:"yaw",property:"angle",source:"vehicle.rot.yaw", scale: 0.5f}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"name\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 6}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 6"}]
execute unless data storage reds_vehicles:logging errors[{code: 6}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - TRANSFORM MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "modify_transform", arguments: {name:"display",property:"angle",source:"vehicle.rot.yaw", scale: 0.5f}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"transform\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 9}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 9"}]
execute unless data storage reds_vehicles:logging errors[{code: 9}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - PROPERTY MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "modify_transform", arguments: {name:"display",transform:"yaw",source:"vehicle.rot.yaw", scale: 0.5f}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"property\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 7}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 7"}]
execute unless data storage reds_vehicles:logging errors[{code: 7}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - SOURCE MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "modify_transform", arguments: {name:"display",transform:"yaw",property:"angle",scale: 0.5f}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"source\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 8}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 8"}]
execute unless data storage reds_vehicles:logging errors[{code: 8}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - NAME AND GROUP SPECIFIED
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "modify_transform", arguments: {name:"display",group:"foobar",transform:"yaw",property:"angle",source:"vehicle.rot.yaw", scale: 0.5f}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"name\" AND \"group\" are provided"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 4}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 4"}]
execute unless data storage reds_vehicles:logging errors[{code: 4}] run return run function rv_unittest:common/fail

#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
