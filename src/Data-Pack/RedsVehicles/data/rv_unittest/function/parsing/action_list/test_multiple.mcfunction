#### UNIT TEST ####
# Try to declare a list of actions
data modify storage reds_vehicles:unittest name set value "parsing/action_list/test_multiple_actions"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare a list of valid actions"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - ALL TAGS SPECIFIED, HIDE_PARTICLES=TRUE
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action_list set value []
data modify storage reds_vehicles:definitions working_action_list append value {action: "effect_passenger", arguments: {name:"minecraft:water_breathing",duration:2,amplifier:23,hide_particles:1b}}
data modify storage reds_vehicles:definitions working_action_list append value {action: "playsound", arguments: {sound:"minecraft:block.stone.break",pitch:4.5,volume:2.1}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action_list/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_action_list[0] run data modify storage reds_vehicles:unittest reason set value {text:"working_action_list was unexpectedly truncated to zero elements"}
execute unless data storage reds_vehicles:definitions working_action_list[0] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action_list[1] run data modify storage reds_vehicles:unittest reason set value {text:"working_action_list was unexpectedly truncated to one element"}
execute unless data storage reds_vehicles:definitions working_action_list[1] run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_action_list[2] run data modify storage reds_vehicles:unittest reason set value {text:"working_action_list was somehow expanded past two elements"}
execute if data storage reds_vehicles:definitions working_action_list[2] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action_list[{action: "effect_passenger"}] run data modify storage reds_vehicles:unittest reason set value {text:"Dropped effect_passenger action from action list"}
execute unless data storage reds_vehicles:definitions working_action_list[{action: "effect_passenger"}] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action_list[{action: "playsound"}] run data modify storage reds_vehicles:unittest reason set value {text:"Dropped playsound action from action list"}
execute unless data storage reds_vehicles:definitions working_action_list[{action: "playsound"}] run return run function rv_unittest:common/fail


#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
