#### UNIT TEST ####
# Try to declare a valid "effect_passenger" actions
data modify storage reds_vehicles:unittest name set value "parsing/default_score/test_valid_input"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare a default_score element using valid input"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - AUTOMATIC PRECISION
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_default_score set value {name: "vehicle.thrust", value: 0.5}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/default_score/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_default_score{name: "vehicle.thrust"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_default_score.name to be \"vehicle.thrust.max\" (was"},{nbt:"working_default_score.name", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_default_score{name: "vehicle.thrust"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_default_score{value: 500} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_default_score.value to be 50 (was "},{nbt:"working_default_score.value", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_default_score{value: 500} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_default_score.precision run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_default_score.precision to have been removed"}
execute if data storage reds_vehicles:definitions working_default_score.precision run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - EXPLICIT PRECISION
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_default_score set value {name: "vehicle.nonstandard", value: 0.25f, precision: 1000}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/default_score/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_default_score{name: "vehicle.nonstandard"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_default_score.name to be \"vehicle.nonstandard\" (was"},{nbt:"working_default_score.name", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_default_score{name: "vehicle.nonstandard"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_default_score{value: 250} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_default_score.value to be 250 (was "},{nbt:"working_default_score.value", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_default_score{value: 250} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_default_score.precision run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_default_score.precision to have been removed"}
execute if data storage reds_vehicles:definitions working_default_score.precision run return run function rv_unittest:common/fail


#####################################################################################################


# Everything passed!
return run function rv_unittest:common/pass
