#### UNIT TEST ####
# Try to declare a valid "modify_transform" actions
data modify storage reds_vehicles:unittest name set value "parsing/action/modify_transform/test_valid_input"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare a modify_transform action using valid input"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - ALL TAGS SPECIFIED, SELECTED BY NAME
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "modify_transform", arguments: {name:"display",transform:"yaw",property:"angle",source:"vehicle.rot.yaw", scale: 0.5f}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_action{action: "modify_transform"} run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.action was somehow converted to \""},{nbt:"working_action.action", storage:"reds_vehicles:definitions"},{text:"\""}]
execute unless data storage reds_vehicles:definitions working_action{action: "modify_transform"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{selector:"@s[name=display]"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.selector to be \"@s[name=display]\" (was "},{nbt:"working_action.arguments.selector", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{selector:"@s[name=display]"} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_action.arguments.name run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.arguments.name was not removed"}]
execute if data storage reds_vehicles:definitions working_action.arguments.name run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{transform:"yaw"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.transform to be \"yaw\" (was "},{nbt:"working_action.arguments.transform", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{transform:"yaw"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{property:"angle"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.property to be \"angle\" (was "},{nbt:"working_action.arguments.parameter", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{property:"angle"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{source:"vehicle.rot.yaw"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.source to be \"vehicle.rot.yaw\" (was "},{nbt:"working_action.arguments.parameter", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{source:"vehicle.rot.yaw"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{scale:0.00005f} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.scale to be 0.0005f (was "},{nbt:"working_action.arguments.scale", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{scale:0.00005f} run return run function rv_unittest:common/fail

#####################################################################################################


# Setup - ALL TAGS SPECIFIED, SELECTED BY GROUP
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "modify_transform", arguments: {group:"foobar",transform:"yaw",property:"angle",source:"vehicle.rot.yaw", scale: 0.5f}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_action.arguments{selector:"@s[tag=foobar]"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.selector to be \"@s[tag=foobar]\" (was "},{nbt:"working_action.arguments.selector", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{selector:"@s[tag=foobar]"} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_action.arguments.group run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.arguments.group was not removed"}]
execute if data storage reds_vehicles:definitions working_action.arguments.group run return run function rv_unittest:common/fail

#####################################################################################################


# Setup - OPTIONAL TAGS ABSENT
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "modify_transform", arguments: {name:"display",transform:"pitch",property:"angle",source:"vehicle.rot.pitch"}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_action{action: "modify_transform"} run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.action was somehow converted to \""},{nbt:"working_action.action", storage:"reds_vehicles:definitions"},{text:"\""}]
execute unless data storage reds_vehicles:definitions working_action{action: "modify_transform"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{selector:"@s[name=display]"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.selector to be \"@s[name=display]\" (was "},{nbt:"working_action.arguments.selector", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{selector:"@s[name=display]"} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_action.arguments.name run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.arguments.name was not removed"}]
execute if data storage reds_vehicles:definitions working_action.arguments.name run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{transform:"pitch"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.transform to be \"pitch\" (was "},{nbt:"working_action.arguments.transform", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{transform:"pitch"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{property:"angle"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.property to be \"angle\" (was "},{nbt:"working_action.arguments.parameter", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{property:"angle"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{source:"vehicle.rot.pitch"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.source to be \"vehicle.rot.yaw\" (was "},{nbt:"working_action.arguments.source", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{source:"vehicle.rot.pitch"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{scale:0.0001f} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.scale to be 0.001f (was "},{nbt:"working_action.arguments.scale", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{scale:0.0001f} run return run function rv_unittest:common/fail

#####################################################################################################


# Everything passed!
return run function rv_unittest:common/pass
