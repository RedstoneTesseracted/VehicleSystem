#### UNIT TEST ####
# Try to declare a valid "set_transform" actions
data modify storage reds_vehicles:unittest name set value "parsing/action/set_transform/test_valid_input"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare a set_transform action using valid input"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - ALL TAGS SPECIFIED, SELECTED BY NAME
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_transform", arguments: {name:"display",transform:"left_rotation",parameter:{angle:45.0f,axis:[1.0f,0.0f,0.0f]}}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_action{action: "set_transform"} run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.action was somehow converted to \""},{nbt:"working_action.action", storage:"reds_vehicles:definitions"},{text:"\""}]
execute unless data storage reds_vehicles:definitions working_action{action: "set_transform"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{selector:"@s[name=display]"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.selector to be \"@s[name=display]\" (was "},{nbt:"working_action.arguments.selector", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{selector:"@s[name=display]"} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_action.arguments.name run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.arguments.name was not removed"}]
execute if data storage reds_vehicles:definitions working_action.arguments.name run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{transform:"left_rotation"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.transform to be \"left_rotation\" (was "},{nbt:"working_action.arguments.transform", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{transform:"left_rotation"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{parameter:{angle:45.0f,axis:[1.0f,0.0f,0.0f]}} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.parameter to be {angle:45.0f,axis:[1.0f,0.0f,0.0f]} (was "},{nbt:"working_action.arguments.parameter", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{parameter:{angle:45.0f,axis:[1.0f,0.0f,0.0f]}} run return run function rv_unittest:common/fail

#####################################################################################################


# Setup - ALL TAGS SPECIFIED, SELECTED BY GROUP
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "set_transform", arguments: {group:"display",transform:"left_rotation",parameter:{angle:45.0f,axis:[1.0f,0.0f,0.0f]}}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_action{action: "set_transform"} run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.action was somehow converted to \""},{nbt:"working_action.action", storage:"reds_vehicles:definitions"},{text:"\""}]
execute unless data storage reds_vehicles:definitions working_action{action: "set_transform"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{selector:"@s[tag=display]"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.selector to be \"@s[tag=display]\" (was "},{nbt:"working_action.arguments.selector", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{selector:"@s[tag=display]"} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_action.arguments.group run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.arguments.group was not removed"}]
execute if data storage reds_vehicles:definitions working_action.arguments.group run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{transform:"left_rotation"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.transform to be \"left_rotation\" (was "},{nbt:"working_action.arguments.transform", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{transform:"left_rotation"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{parameter:{angle:45.0f,axis:[1.0f,0.0f,0.0f]}} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.parameter to be {angle:45.0f,axis:[1.0f,0.0f,0.0f]} (was "},{nbt:"working_action.arguments.parameter", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{parameter:{angle:45.0f,axis:[1.0f,0.0f,0.0f]}} run return run function rv_unittest:common/fail

#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
