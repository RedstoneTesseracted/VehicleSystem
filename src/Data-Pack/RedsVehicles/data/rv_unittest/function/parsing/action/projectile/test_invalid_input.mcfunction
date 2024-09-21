#### UNIT TEST ####
# Try to declare a valid "projectile" actions
data modify storage reds_vehicles:unittest name set value "parsing/action/projectile/test_invalid_input"
data modify storage reds_vehicles:unittest description set value {text:"Make sure we can catch invalid input when trying to declare a projectile action"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - ALL ARGUMENTS MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "projectile", arguments: {}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when all arguments are missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - NAME MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "projectile", arguments: {direction:"forward"}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"name\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - DIRECTION MISSING
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "projectile", arguments: {name:"arrow"}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run data modify storage reds_vehicles:unittest reason set value {text:"Should not have passed when \"direction\" is missing"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 1 run return run function rv_unittest:common/fail

#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
