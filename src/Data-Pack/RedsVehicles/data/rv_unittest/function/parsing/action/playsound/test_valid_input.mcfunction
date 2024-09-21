#### UNIT TEST ####
# Try to declare a valid "playsound" actions
data modify storage reds_vehicles:unittest name set value "parsing/action/playsound/test_valid_input"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare a playsound action using valid input"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - ALL TAGS SPECIFIED
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "playsound", arguments: {sound:"minecraft:block.stone.break",pitch:4.5,volume:2.1}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_action{action: "playsound"} run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.action was somehow converted to \""},{nbt:"working_action.action", storage:"reds_vehicles:definitions"},{text:"\""}]
execute unless data storage reds_vehicles:definitions working_action{action: "playsound"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{sound:"minecraft:block.stone.break"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.action to be \"minecraft:block.stone.break\" (was "},{nbt:"working_action.action", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{sound:"minecraft:block.stone.break"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{pitch:4.5} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.pitch to be 4.5 (was "},{nbt:"working_action.arguments.pitch", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{pitch:4.5} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{volume:2.1} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.volume to be 2.1 (was "},{nbt:"working_action.arguments.volume", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{volume:2.1} run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - OPTIONAL TAGS ABSENT
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "playsound", arguments: {sound:"minecraft:block.stone.break"}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_action{action: "playsound"} run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.action was somehow converted to \""},{nbt:"working_action.action", storage:"reds_vehicles:definitions"},{text:"\""}]
execute unless data storage reds_vehicles:definitions working_action{action: "playsound"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{sound:"minecraft:block.stone.break"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.action to be \"minecraft:block.stone.break\" (was "},{nbt:"working_action.action", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{sound:"minecraft:block.stone.break"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{pitch:1.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.pitch to be 1.0 (was "},{nbt:"working_action.arguments.pitch", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{pitch:1.0} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{volume:1.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.volume to be 1.0 (was "},{nbt:"working_action.arguments.volume", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{volume:1.0} run return run function rv_unittest:common/fail

#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
