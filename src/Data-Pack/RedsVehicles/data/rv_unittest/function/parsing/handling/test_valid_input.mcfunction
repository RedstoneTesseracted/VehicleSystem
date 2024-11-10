#### UNIT TEST ####

data modify storage reds_vehicles:unittest name set value "parsing/handling/test_valid_input"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare an handling element using valid input"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - AUTOMATIC PRECISION
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_handling set value {input: "look.x", operation: "increase", scale: {source: "constant",value:2.1f}, variable: "vehicle.dvel.x"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/handling/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_handling{input: "look.x"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_handling.input to be \"input.x\" (was "},{nbt:"working_handling.input", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_handling{input: "look.x"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_handling{operation: "increase"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_handling.operation to be \"increase\" (was "},{nbt:"working_handling.operation", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_handling{operation: "increase"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_handling{variable: "vehicle.dvel.x"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_handling.variable to be \"vehicle.dvel.x\" (was "},{nbt:"working_handling.variable", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_handling{variable: "vehicle.dvel.x"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_handling.scale run data modify storage reds_vehicles:unittest reason set value {text:"Dropped scale field from working_handling"}
execute unless data storage reds_vehicles:definitions working_handling.scale run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_handling{precision: 1000} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_handling.precision to be 100 (was "},{nbt:"working_handling.precision", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_handling{precision: 1000} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_handling{input_group: "look"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_handling.input_group to be \"look\" (was "},{nbt:"working_handling.input_group", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_handling{input_group: "look"} run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - AUTOMATIC PRECISION, SCALE ABSENT
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_handling set value {input: "look.y", operation: "decrease", variable: "vehicle.dvel.y"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/handling/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_handling{input: "look.y"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_handling.input to be \"input.y\" (was "},{nbt:"working_handling.input", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_handling{input: "look.y"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_handling{operation: "decrease"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_handling.operation to be \"increase\" (was "},{nbt:"working_handling.operation", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_handling{operation: "decrease"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_handling{variable: "vehicle.dvel.y"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_handling.variable to be \"vehicle.dvel.y\" (was "},{nbt:"working_handling.variable", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_handling{variable: "vehicle.dvel.y"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_handling.scale run data modify storage reds_vehicles:unittest reason set value {text:"Dropped scale field from working_handling"}
execute unless data storage reds_vehicles:definitions working_handling.scale run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_handling{precision: 1000} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_handling.precision to be 100 (was "},{nbt:"working_handling.precision", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_handling{precision: 1000} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_handling{input_group: "look"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_handling.input_group to be \"look\" (was "},{nbt:"working_handling.input_group", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_handling{input_group: "look"} run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - EXPLICIT PRECISION
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_handling set value {input: "look.z", operation: "set", variable: "vehicle.nonstandard", precision: 100}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/handling/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_handling{variable: "vehicle.nonstandard"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_handling.variable to be \"vehicle.dvel.x\" (was "},{nbt:"working_handling.variable", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_handling{variable: "vehicle.nonstandard"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_handling{precision: 100} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_handling.precision to be 100 (was "},{nbt:"working_handling.precision", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_handling{precision: 100} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_handling{operation: "set"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_handling.operation to be \"set\" (was "},{nbt:"working_handling.input_group", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_handling{operation: "set"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_handling{input_group: "look"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_handling.input_group to be \"look\" (was "},{nbt:"working_handling.input_group", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_handling{input_group: "look"} run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - TOGGLE
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_handling set value {input: "look.z", operation: "toggle", variable: "vehicle.nonstandard"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/handling/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_handling{variable: "vehicle.nonstandard"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_handling.variable to be \"vehicle.dvel.x\" (was "},{nbt:"working_handling.variable", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_handling{variable: "vehicle.nonstandard"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_handling{precision: 1} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_handling.precision to be 100 (was "},{nbt:"working_handling.precision", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_handling{precision: 1} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_handling{operation: "toggle"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_handling.operation to be \"toggle\" (was "},{nbt:"working_handling.input_group", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_handling{operation: "toggle"} run return run function rv_unittest:common/fail


#####################################################################################################

# ALL INPUT SOURCES
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "click", input: "left"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "click", input: "right"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "directed", input: "x"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "directed", input: "y"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "directed", input: "z"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "input", input: "forward"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "input", input: "side"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "look_xz", input: "x"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "look_xz", input: "z"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "look", input: "x"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "look", input: "y"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "look", input: "z"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "motion", input: "x"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "motion", input: "z"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "rotation_diff", input: "pitch"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "rotation_diff", input: "yaw"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "rotation", input: "pitch"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "rotation", input: "yaw"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "heading_diff", input: "pitch"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail
execute store result score vehicle.unittest.input_test_result vehicle.unittest.local run function rv_unittest:parsing/handling/__test_valid_input {group: "heading_diff", input: "yaw"}
execute if score vehicle.unittest.input_test_result vehicle.unittest.local matches 0 run return fail

# Everything passed!
return run function rv_unittest:common/pass
