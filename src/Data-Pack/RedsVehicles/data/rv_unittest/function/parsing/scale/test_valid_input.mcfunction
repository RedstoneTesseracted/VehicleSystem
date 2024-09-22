#### UNIT TEST ####

data modify storage reds_vehicles:unittest name set value "parsing/scale/test_valid_input"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare a scale element using valid input"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - CONSTANT
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_scale set value {source: "constant", value: 2.0}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/scale/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_scale{source: "constant"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_scale.type to be \"constant\" (was "},{nbt:"working_scale.type", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_scale{source: "constant"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_scale{value: 2.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_scale.value to be 2.0 (was "},{nbt:"working_scale.value", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_scale{value: 2.0} run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - SCORE
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_scale set value {source: "score", name: "vehicle.thrust", score_scale: 0.01}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/scale/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_scale{source: "score"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_scale.type to be \"score\" (was "},{nbt:"working_scale.type", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_scale{source: "score"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_scale{name: "vehicle.thrust"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_scale.name to be \"vehicle.thrust\" (was "},{nbt:"working_scale.value", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_scale{name: "vehicle.thrust"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_scale{score_scale: 0.01} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_scale.score_scale to be 0.01d (was "},{nbt:"working_scale.value", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_scale{score_scale: 0.01} run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - NONE
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_scale set value {source: "none"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/scale/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_scale{source: "none"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_scale.type to be \"none\" (was "},{nbt:"working_scale.type", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_scale{source: "none"} run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - SCORE, OPTIONAL FIELDS ABSENT
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_scale set value {source: "score", name: "vehicle.thrust"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/scale/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_scale{source: "score"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_scale.type to be \"score\" (was "},{nbt:"working_scale.type", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_scale{source: "score"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_scale{name: "vehicle.thrust"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_scale.name to be \"vehicle.thrust\" (was "},{nbt:"working_scale.value", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_scale{name: "vehicle.thrust"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_scale{score_scale: 1.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_scale.score_scale to be 1.0d (was "},{nbt:"working_scale.value", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_scale{score_scale: 1.0} run return run function rv_unittest:common/fail


#####################################################################################################


# Everything passed!
return run function rv_unittest:common/pass
