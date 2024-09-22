#### UNIT TEST ####

data modify storage reds_vehicles:unittest name set value "parsing/physics/test_valid_input"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare an physics element using valid input"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - GRAVITY
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_physics set value {type: "gravity", value: 0.04}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/physics/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_physics{type: "gravity"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_physics.type to be \"gravity\" (was "},{nbt:"working_physics.type", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_physics{type: "gravity"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_physics{value: 0.04} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_physics.value to be 0.04 (was "},{nbt:"working_physics.value", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_physics{value: 0.04} run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - BUOYANT
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_physics set value {type: "buoyant", value: 1.0, predicates: ["reds_vehicles:environment/in_water", "reds_vehicles:state/engine_on"]}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/physics/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_physics{type: "buoyant"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_physics.type to be \"buoyant\" (was "},{nbt:"working_physics.type", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_physics{type: "buoyant"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_physics{value: -1.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_physics.value to be 1.0 (was "},{nbt:"working_physics.value", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_physics{value: -1.0} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_physics{predicate: "if predicate reds_vehicles:environment/in_water if predicate reds_vehicles:state/engine_on "} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_physics.predicate to be \"if predicate reds_vehicles:environment/in_water if predicate reds_vehicles:state/engine_on \" (was "},{nbt:"working_physics.predicate", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_physics{predicate: "if predicate reds_vehicles:environment/in_water if predicate reds_vehicles:state/engine_on "} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions predicates run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_physics.predicates to have been dropped"}
execute if data storage reds_vehicles:definitions predicates run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - SIMPLE LIFT
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_physics set value {type: "simple_lift", value: 1.0, predicates: ["reds_vehicles:environment/in_air", "reds_vehicles:is_moving"]}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/physics/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_physics{type: "simple_lift"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_physics.type to be \"simple_lift\" (was "},{nbt:"working_physics.type", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_physics{type: "simple_lift"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_physics{value: 1.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_physics.value to be 1.0 (was "},{nbt:"working_physics.value", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_physics{value: 1.0} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_physics{predicate: "if predicate reds_vehicles:environment/in_air if predicate reds_vehicles:is_moving "} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_physics.predicate to be \"if predicate reds_vehicles:environment/in_air if predicate reds_vehicles:state/is_moving \" (was "},{nbt:"working_physics.predicate", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_physics{predicate: "if predicate reds_vehicles:environment/in_air if predicate reds_vehicles:is_moving "} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions predicates run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_physics.predicates to have been dropped"}
execute if data storage reds_vehicles:definitions predicates run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - PLANAR DRAG
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_physics set value {type: "planar_drag", value: 1.0, predicates: ["reds_vehicles:environment/in_air", "reds_vehicles:is_moving"]}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/physics/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_physics{type: "planar_drag"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_physics.type to be \"planar_drag\" (was "},{nbt:"working_physics.type", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_physics{type: "planar_drag"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_physics{value: 1.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_physics.value to be 1.0 (was "},{nbt:"working_physics.value", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_physics{value: 1.0} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_physics{predicate: "if predicate reds_vehicles:environment/in_air if predicate reds_vehicles:is_moving "} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_physics.predicate to be \"if predicate reds_vehicles:environment/in_air if predicate reds_vehicles:state/is_moving \" (was "},{nbt:"working_physics.predicate", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_physics{predicate: "if predicate reds_vehicles:environment/in_air if predicate reds_vehicles:is_moving "} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions predicates run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_physics.predicates to have been dropped"}
execute if data storage reds_vehicles:definitions predicates run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - APPLIED
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_physics set value {type: "applied", value: 1.0}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/physics/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_physics{type: "applied"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_physics.type to be \"applied\" (was "},{nbt:"working_physics.type", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_physics{type: "applied"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_physics{value: 1.0} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_physics.value to be 1.0 (was "},{nbt:"working_physics.value", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_physics{value: 1.0} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_physics{predicate: ""} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_physics.predicate to be \"\" (was "},{nbt:"working_physics.predicate", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_physics{predicate: ""} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions predicates run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_physics.predicates to have been dropped"}
execute if data storage reds_vehicles:definitions predicates run return run function rv_unittest:common/fail


#####################################################################################################


# Everything passed!
return run function rv_unittest:common/pass
