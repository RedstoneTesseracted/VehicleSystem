#### UNIT TEST ####
# Try to declare a valid "set_rotation_axis_angle" actions
data modify storage reds_vehicles:unittest name set value "parsing/action/set_rotation_axis_angle/test_invalid_input"
data modify storage reds_vehicles:unittest description set value {text:"Make sure we can catch invalid input when trying to declare a set_rotation_axis_angle action"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - NAME & GROUP MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_rotation_axis_angle", arguments: {transform:"yaw",axis:[1.0f,0.0f,0.0f],source:"vehicle.rot.yaw", scale: 0.5f}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"name\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 24}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 24"}]
execute unless data storage reds_vehicles:logging errors[{code: 24}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - TRANSFORM MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_rotation_axis_angle", arguments: {name:"display",axis:[1.0f,0.0f,0.0f],source:"vehicle.rot.yaw", scale: 0.5f}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"transform\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 27}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 27"}]
execute unless data storage reds_vehicles:logging errors[{code: 27}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - AXIS MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_rotation_axis_angle", arguments: {name:"display",transform:"yaw",source:"vehicle.rot.yaw", scale: 0.5f}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"axis\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 25}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 25"}]
execute unless data storage reds_vehicles:logging errors[{code: 25}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - SOURCE MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_rotation_axis_angle", arguments: {name:"display",transform:"yaw",axis:[1.0f,0.0f,0.0f],scale: 0.5f}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"source\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 26}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 26"}]
execute unless data storage reds_vehicles:logging errors[{code: 26}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - NAME AND GROUP SPECIFIED
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_rotation_axis_angle", arguments: {name:"display",group:"foobar",transform:"yaw",axis:[1.0f,0.0f,0.0f],source:"vehicle.rot.yaw", scale: 0.5f}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"name\" AND \"group\" are provided"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 22}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 22"}]
execute unless data storage reds_vehicles:logging errors[{code: 22}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - GARBLED NAME
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_rotation_axis_angle", arguments: {name:"\"foobar\"",transform:"yaw",axis:[1.0f,0.0f,0.0f],source:"vehicle.rot.yaw", scale: 0.5f}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"name\" is garbled"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 28}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 28"}]
execute unless data storage reds_vehicles:logging errors[{code: 28}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - GARBLED GROUP
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_rotation_axis_angle", arguments: {group:"\"foobar\"",transform:"yaw",axis:[1.0f,0.0f,0.0f],source:"vehicle.rot.yaw", scale: 0.5f}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"group\" is garbled"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 23}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 23"}]
execute unless data storage reds_vehicles:logging errors[{code: 23}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - DOUBLE SCALE
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_rotation_axis_angle", arguments: {group:"foobar",transform:"yaw",axis:[1.0f,0.0f,0.0f],source:"vehicle.rot.yaw", scale: 0.5d}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"scale\" is a double"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 30}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 30"}]
execute unless data storage reds_vehicles:logging errors[{code: 30}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - AXIS TOO SHORT
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_rotation_axis_angle", arguments: {group:"foobar",transform:"yaw",axis:[1.0f,0.0f],source:"vehicle.rot.yaw", scale: 0.5f}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"axis\" is a 2-vector"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 21}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 21"}]
execute unless data storage reds_vehicles:logging errors[{code: 21}] run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - AXIS TOO LONG
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_rotation_axis_angle", arguments: {group:"foobar",transform:"yaw",axis:[1.0f,0.0f,0.0f,0.0f],source:"vehicle.rot.yaw", scale: 0.5f}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"axis\" is a 4-vector"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 21}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 21"}]
execute unless data storage reds_vehicles:logging errors[{code: 21}] run return run function rv_unittest:common/fail

#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
