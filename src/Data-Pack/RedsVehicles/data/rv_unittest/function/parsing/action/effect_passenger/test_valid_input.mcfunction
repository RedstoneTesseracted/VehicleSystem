#### UNIT TEST ####
data modify storage reds_vehicles:unittest name set value "parsing/action/effect_passenger/test_valid_input"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare a effect_passenger action using valid input"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - ALL TAGS SPECIFIED, HIDE_PARTICLES=TRUE
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "effect_passenger", arguments: {name:"minecraft:water_breathing",duration:2,amplifier:23,hide_particles:1b}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_action{action: "effect_passenger"} run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.action was somehow converted to \""},{nbt:"working_action.action", storage:"reds_vehicles:definitions"},{text:"\""}]
execute unless data storage reds_vehicles:definitions working_action{action: "effect_passenger"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{name:"minecraft:water_breathing"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.action.name to be \"minecraft:water_breathing\" (was "},{nbt:"working_action.action.name", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{name:"minecraft:water_breathing"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{duration:2} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.duration to be 2 (was "},{nbt:"working_action.arguments.duration", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{duration:2} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{amplifier:23} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.amplifier to be 23 (was "},{nbt:"working_action.arguments.amplifier", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{amplifier:23} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{hide_particles:"true"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.hide_particles to be \"true\" (was "},{nbt:"working_action.arguments.hide_particles", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{hide_particles:"true"} run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - ALL TAGS SPECIFIED, HIDE_PARTICLES=FALSE
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "effect_passenger", arguments: {name:"minecraft:water_breathing",duration:2,amplifier:23,hide_particles:0b}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_action.arguments{hide_particles:"false"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.hide_particles to be \"false\" (was "},{nbt:"working_action.arguments.hide_particles", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{hide_particles:"false"} run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - OPTIONAL TAGS ABSENT
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "effect_passenger", arguments: {name:"minecraft:water_breathing"}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_action{action: "effect_passenger"} run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.action was somehow converted to \""},{nbt:"working_action.action", storage:"reds_vehicles:definitions"},{text:"\""}]
execute unless data storage reds_vehicles:definitions working_action{action: "effect_passenger"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{name:"minecraft:water_breathing"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.name to be \"minecraft:water_breathing\" (was "},{nbt:"working_action.arguments.name", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{name:"minecraft:water_breathing"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{duration:0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.duration to be 0 (was "},{nbt:"working_action.arguments.duration", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{duration:0} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{amplifier:0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.amplifier to be 0 (was "},{nbt:"working_action.arguments.amplifier", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{amplifier:0} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{hide_particles:"true"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.arguments.hide_particles to be \"true\" (was "},{nbt:"working_action.arguments.hide_particles", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{hide_particles:"true"} run return run function rv_unittest:common/fail

#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
