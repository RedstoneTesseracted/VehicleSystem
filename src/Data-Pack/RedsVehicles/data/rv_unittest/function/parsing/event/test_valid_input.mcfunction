#### UNIT TEST ####
data modify storage reds_vehicles:unittest name set value "parsing/event/test_valid_input"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare an event element using valid input"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - FULL
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_event set value {trigger: "vehicle.horn.honk", predicates: ["reds_vehicles:has_passenger","reds_vehicles:environment/in_air"], actions: [{action: "playsound", arguments: {sound:"minecraft:block.stone.break"}}]}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/event/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_event.actions[0] run data modify storage reds_vehicles:unittest reason set value {text:"Dropped actions list"}
execute unless data storage reds_vehicles:definitions working_event.actions[0] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_event{predicate: "unless score @s vehicle.horn.honk matches 0 if predicate reds_vehicles:has_passenger if predicate reds_vehicles:environment/in_air "} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_event.predicate to be \"unless score @s vehicle.horn.honk matches 0 if predicate reds_vehicles:has_passenger if predicate reds_vehicles:environment/in_air \" (was "},{nbt:"working_event.predicate", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_event{predicate: "unless score @s vehicle.horn.honk matches 0 if predicate reds_vehicles:has_passenger if predicate reds_vehicles:environment/in_air "} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_event.trigger run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_event.trigger to have been removed"}
execute if data storage reds_vehicles:definitions working_event.trigger run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_event.predicates run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_event.predicates to have been removed"}
execute if data storage reds_vehicles:definitions working_event.predicates run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - NO TRIGGER
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_event set value {predicates: ["reds_vehicles:has_passenger","reds_vehicles:environment/in_air"], actions: [{action: "playsound", arguments: {sound:"minecraft:block.stone.break"}}]}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/event/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_event.actions[0] run data modify storage reds_vehicles:unittest reason set value {text:"Dropped actions list"}
execute unless data storage reds_vehicles:definitions working_event.actions[0] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_event{predicate: "if predicate reds_vehicles:has_passenger if predicate reds_vehicles:environment/in_air "} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_event.predicate to be \"if predicate reds_vehicles:has_passenger if predicate reds_vehicles:environment/in_air \" (was "},{nbt:"working_event.predicate", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_event{predicate: "if predicate reds_vehicles:has_passenger if predicate reds_vehicles:environment/in_air "} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_event.trigger run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_event.trigger to have been removed"}
execute if data storage reds_vehicles:definitions working_event.trigger run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_event.predicates run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_event.predicates to have been removed"}
execute if data storage reds_vehicles:definitions working_event.predicates run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - NO PREDICATES LIST
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_event set value {trigger: "vehicle.horn.honk", actions: [{action: "playsound", arguments: {sound:"minecraft:block.stone.break"}}]}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/event/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_event.actions[0] run data modify storage reds_vehicles:unittest reason set value {text:"Dropped actions list"}
execute unless data storage reds_vehicles:definitions working_event.actions[0] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_event{predicate: "unless score @s vehicle.horn.honk matches 0 "} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_event.predicate to be \"unless score @s vehicle.horn.honk matches 0 \" (was "},{nbt:"working_event.predicate", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_event{predicate: "unless score @s vehicle.horn.honk matches 0 "} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_event.trigger run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_event.trigger to have been removed"}
execute if data storage reds_vehicles:definitions working_event.trigger run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_event.predicates run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_event.predicates to have been removed"}
execute if data storage reds_vehicles:definitions working_event.predicates run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - NO PREDICATES OR TRIGGER
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_event set value {actions: [{action: "playsound", arguments: {sound:"minecraft:block.stone.break"}}]}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/event/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_event.actions[0] run data modify storage reds_vehicles:unittest reason set value {text:"Dropped actions list"}
execute unless data storage reds_vehicles:definitions working_event.actions[0] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_event{predicate: ""} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_event.predicate to be \"\" (was "},{nbt:"working_event.predicate", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_event{predicate: ""} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_event.trigger run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_event.trigger to have been removed"}
execute if data storage reds_vehicles:definitions working_event.trigger run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_event.predicates run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_event.predicates to have been removed"}
execute if data storage reds_vehicles:definitions working_event.predicates run return run function rv_unittest:common/fail

#####################################################################################################


# Everything passed!
return run function rv_unittest:common/pass
