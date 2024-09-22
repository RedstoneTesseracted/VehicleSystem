#### UNIT TEST ####
data modify storage reds_vehicles:unittest name set value "parsing/event_list/test_multiple"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare a list of events"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_event_list set value []
data modify storage reds_vehicles:definitions working_event_list append value {trigger: "vehicle.horn.honk", predicates: ["reds_vehicles:something"], actions: [{action: "playsound", arguments: {sound:"minecraft:block.stone.break"}}]}
data modify storage reds_vehicles:definitions working_event_list append value {actions: [{action: "particle", arguments: {name:"minecraft:bubble"}}]}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/event_list/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_event_list[0] run data modify storage reds_vehicles:unittest reason set value {text:"working_event_list was unexpectedly truncated to zero elements"}
execute unless data storage reds_vehicles:definitions working_event_list[0] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_event_list[1] run data modify storage reds_vehicles:unittest reason set value {text:"working_event_list was unexpectedly truncated to one element"}
execute unless data storage reds_vehicles:definitions working_event_list[1] run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_event_list[2] run data modify storage reds_vehicles:unittest reason set value {text:"working_event_list was somehow expanded past two elements"}
execute if data storage reds_vehicles:definitions working_event_list[2] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_event_list[0].actions[{action: "playsound"}] run data modify storage reds_vehicles:unittest reason set value {text:"Dropped event that plays a sound from the event list"}
execute unless data storage reds_vehicles:definitions working_event_list[0].actions[{action: "playsound"}] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_event_list[1].actions[{action: "particle"}] run data modify storage reds_vehicles:unittest reason set value {text:"Dropped event that spawns particles from the event list"}
execute unless data storage reds_vehicles:definitions working_event_list[1].actions[{action: "particle"}] run return run function rv_unittest:common/fail


#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
