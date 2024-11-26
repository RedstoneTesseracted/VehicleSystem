#### UNIT TEST ####
data modify storage reds_vehicles:unittest name set value "parsing/root/test_invalid_input"
data modify storage reds_vehicles:unittest description set value {text:"Make sure we can catch invalid input when trying to declare a vehicle"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - MINIMUM VERSION TOO NEW
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

function rv_unittest:parsing/root/valid_sample
data modify storage reds_vehicles:definitions working_root.min_version set value 1000000

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/root/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"min_version\" is greater than the current datapack version"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 69}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 69"}]
execute unless data storage reds_vehicles:logging errors[{code: 69}] run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - MINIMUM VERSION MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

function rv_unittest:parsing/root/valid_sample
data remove storage reds_vehicles:definitions working_root.min_version

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/root/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"min_version\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 68}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 68"}]
execute unless data storage reds_vehicles:logging errors[{code: 68}] run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - AUTHOR MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

function rv_unittest:parsing/root/valid_sample
data remove storage reds_vehicles:definitions working_root.author

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/root/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"author\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail
# Check number of errors
execute unless function rv_unittest:common/assert_one_error run return run function rv_unittest:common/fail
# Check error code
execute unless data storage reds_vehicles:logging errors[{code: 85}] run data modify storage reds_vehicles:unittest reason set value [{text:"Expected error code to be 85"}]
execute unless data storage reds_vehicles:logging errors[{code: 85}] run return run function rv_unittest:common/fail


#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
