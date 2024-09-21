#### UNIT TEST ####
# Try to declare a valid "relative_particle" actions
data modify storage reds_vehicles:unittest name set value "parsing/action/relative_particle/test_valid_input"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare a relative_particle action using valid input"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - ALL TAGS SPECIFIED
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "relative_particle", arguments: {name:"minecraft:bubble",relative_to:"display",offset:[1.0,2.0,3.0],delta:[4.0,5.0,6.0],count:20,speed:0.1}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_action{action: "relative_particle"} run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.action was somehow converted to \""},{nbt:"working_action.action", storage:"reds_vehicles:definitions"},{text:"\""}]
execute unless data storage reds_vehicles:definitions working_action{action: "relative_particle"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{name:"minecraft:bubble"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.name to be \"minecraft:block.stone.break\" (was "},{nbt:"working_action.arguments.name", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{name:"minecraft:bubble"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{offsetU:1.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.offsetU to be 1.0 (was "},{nbt:"working_action.arguments.offsetU", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{offsetU:1.0} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{offsetV:2.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.offsetV to be 2.0 (was "},{nbt:"working_action.arguments.offsetV", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{offsetV:2.0} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{offsetW:3.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.offsetW to be 3.0 (was "},{nbt:"working_action.arguments.offsetW", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{offsetW:3.0} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_action.arguments.offset run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.arguments.offset arguments was not removed"}]
execute if data storage reds_vehicles:definitions working_action.arguments.offset run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{deltaX:4.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.deltaX to be 4.0 (was "},{nbt:"working_action.arguments.deltaX", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{deltaX:4.0} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{deltaY:5.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.deltaY to be 5.0 (was "},{nbt:"working_action.arguments.deltaY", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{deltaY:5.0} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{deltaZ:6.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.deltaZ to be 6.0 (was "},{nbt:"working_action.arguments.deltaZ", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{deltaZ:6.0} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_action.arguments.delta run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.arguments.delta arguments was not removed"}]
execute if data storage reds_vehicles:definitions working_action.arguments.delta run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{count:20} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.count to be 20 (was "},{nbt:"working_action.arguments.count", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{count:20} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{speed:0.1} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.speed to be 0.1 (was "},{nbt:"working_action.arguments.speed", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{speed:0.1} run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - OPTIONAL TAGS ABSENT
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "relative_particle", arguments: {name:"minecraft:bubble",relative_to:"display"}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_action{action: "relative_particle"} run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.action was somehow converted to \""},{nbt:"working_action.action", storage:"reds_vehicles:definitions"},{text:"\""}]
execute unless data storage reds_vehicles:definitions working_action{action: "relative_particle"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{name:"minecraft:bubble"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.name to be \"minecraft:block.stone.break\" (was "},{nbt:"working_action.arguments.name", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{name:"minecraft:bubble"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{offsetU:0.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.offsetU to be 0.0 (was "},{nbt:"working_action.arguments.offsetU", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{offsetU:0.0} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{offsetV:0.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.offsetV to be 0.0 (was "},{nbt:"working_action.arguments.offsetV", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{offsetV:0.0} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{offsetW:0.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.offsetW to be 0.0 (was "},{nbt:"working_action.arguments.offsetW", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{offsetW:0.0} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_action.arguments.offset run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.arguments.offset arguments was not removed"}]
execute if data storage reds_vehicles:definitions working_action.arguments.offset run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{deltaX:0.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.deltaX to be 0.0 (was "},{nbt:"working_action.arguments.deltaX", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{deltaX:0.0} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{deltaY:0.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.deltaY to be 0.0 (was "},{nbt:"working_action.arguments.deltaY", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{deltaY:0.0} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{deltaZ:0.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.deltaZ to be 0.0 (was "},{nbt:"working_action.arguments.deltaZ", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{deltaZ:0.0} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_action.arguments.delta run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.arguments.delta arguments was not removed"}]
execute if data storage reds_vehicles:definitions working_action.arguments.delta run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{count:1} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.count to be 1 (was "},{nbt:"working_action.arguments.count", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{count:1} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{speed:0.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.speed to be 0.0 (was "},{nbt:"working_action.arguments.speed", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{speed:0.0} run return run function rv_unittest:common/fail

#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
