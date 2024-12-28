#### UNIT TEST ####
# Try to declare a valid "set_model" actions
data modify storage reds_vehicles:unittest name set value "parsing/action/set_model/test_valid_input"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare a set_model action using valid input"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - ALL TAGS SPECIFIED
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_model", arguments: {name:"display",value:"reds_vehicles:vehicle/test"}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_action{action: "set_model"} run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.action was somehow converted to \""},{nbt:"working_action.action", storage:"reds_vehicles:definitions"},{text:"\""}]
execute unless data storage reds_vehicles:definitions working_action{action: "set_model"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{name:"display"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.name to be \"display\" (was "},{nbt:"working_action.arguments.name", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{name:"display"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{value:"reds_vehicles:vehicle/test"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.value to be \"reds_vehicles:vehicle/test\" (was "},{nbt:"working_action.arguments.value", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{value:"reds_vehicles:vehicle/test"} run return run function rv_unittest:common/fail

#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
