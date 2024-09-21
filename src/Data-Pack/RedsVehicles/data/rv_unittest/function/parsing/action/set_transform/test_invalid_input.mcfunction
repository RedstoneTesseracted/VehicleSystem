#### UNIT TEST ####
# Try to declare a valid "set_transform" actions
data modify storage reds_vehicles:unittest name set value "parsing/action/set_transform/test_invalid_input"
data modify storage reds_vehicles:unittest description set value {text:"Make sure we can catch invalid input when trying to declare a set_transform action"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - ALL ARGUMENTS MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_transform", arguments: {}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when all arguments are missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail

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

#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
