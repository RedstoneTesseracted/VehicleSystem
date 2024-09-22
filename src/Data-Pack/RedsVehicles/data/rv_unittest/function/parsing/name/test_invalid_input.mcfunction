#### UNIT TEST ####
data modify storage reds_vehicles:unittest name set value "parsing/name/test_invalid_input"
data modify storage reds_vehicles:unittest description set value {text:"Make sure we can catch invalid input when trying to declare an name"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - NAME MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[],working_root:{}}
function reds_vehicles:define/logging/reset

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/name/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"name\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 57}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 57"}]
execute unless data storage reds_vehicles:logging errors[{code: 57}] run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - ZERO LENGTH NAME
data merge storage reds_vehicles:definitions {vehicles:[],processed:[],working_root:{}}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_root.name set value ""

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/name/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"name\" is zero length"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 60}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 60"}]
execute unless data storage reds_vehicles:logging errors[{code: 60}] run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - NAME TAKEN
data merge storage reds_vehicles:definitions {vehicles:[],processed:[{name:"foobar"}],working_root:{}}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_root.name set value "foobar"

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/name/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"name\" is zero taken"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 58}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 58"}]
execute unless data storage reds_vehicles:logging errors[{code: 58}] run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - WRONG DATA TYPE
data merge storage reds_vehicles:definitions {vehicles:[],processed:[],working_root:{}}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_root.name set value {value:"dngualirtbhgui"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/name/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"name\" is a compound"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 59}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 59"}]
execute unless data storage reds_vehicles:logging errors[{code: 59}] run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - GARBLED NAME
data merge storage reds_vehicles:definitions {vehicles:[],processed:[],working_root:{}}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_root.name set value "'foobar"

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/name/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"name\" is garbled"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 56}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 56"}]
execute unless data storage reds_vehicles:logging errors[{code: 56}] run return run function rv_unittest:common/fail


#####################################################################################################



# Everything passed!
return run function rv_unittest:common/pass
