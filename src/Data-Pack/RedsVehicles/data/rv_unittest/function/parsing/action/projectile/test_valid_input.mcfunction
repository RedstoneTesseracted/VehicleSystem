#### UNIT TEST ####
# Try to declare a valid "projectile" actions
data modify storage reds_vehicles:unittest name set value "parsing/action/projectile/test_valid_input"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare a projectile action using valid input"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - ALL TAGS SPECIFIED
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "projectile", arguments: {name:"arrow",direction:"forward"}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_action{action: "projectile"} run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.action was somehow converted to \""},{nbt:"working_action.action", storage:"reds_vehicles:definitions"},{text:"\""}]
execute unless data storage reds_vehicles:definitions working_action{action: "projectile"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{name:"arrow"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.name to be \"arrow\" (was "},{nbt:"working_action.arguments.name", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{name:"arrow"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{direction:"forward"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.pitch to be \"forward\" (was "},{nbt:"working_action.arguments.pitch", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{direction:"forward"} run return run function rv_unittest:common/fail

#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
