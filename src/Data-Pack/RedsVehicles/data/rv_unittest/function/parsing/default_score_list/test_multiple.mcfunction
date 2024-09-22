#### UNIT TEST ####
# Try to declare a list of actions
data modify storage reds_vehicles:unittest name set value "parsing/default_score_list/test_multiple"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare a list of default scores"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - ALL TAGS SPECIFIED, HIDE_PARTICLES=TRUE
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions default_score_list set value []
data modify storage reds_vehicles:definitions default_score_list append value {name: "vehicle.thrust", value: 0.5}
data modify storage reds_vehicles:definitions default_score_list append value {name: "vehicle.nonstandard", value: 0.25f, precision: 1000}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/default_score_list/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions default_score_list[0] run data modify storage reds_vehicles:unittest reason set value {text:"default_score_list was unexpectedly truncated to zero elements"}
execute unless data storage reds_vehicles:definitions default_score_list[0] run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions default_score_list[1] run data modify storage reds_vehicles:unittest reason set value {text:"default_score_list was unexpectedly truncated to one element"}
execute unless data storage reds_vehicles:definitions default_score_list[1] run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions default_score_list[2] run data modify storage reds_vehicles:unittest reason set value {text:"default_score_list was somehow expanded past two elements"}
execute if data storage reds_vehicles:definitions default_score_list[2] run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions default_score_list[{name: "vehicle.thrust"}] run data modify storage reds_vehicles:unittest reason set value {text:"Dropped vehicle.thrust element from default score list"}
execute unless data storage reds_vehicles:definitions default_score_list[{name: "vehicle.thrust"}] run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions default_score_list[{name: "vehicle.nonstandard"}] run data modify storage reds_vehicles:unittest reason set value {text:"Dropped vehicle.nonstandard element from default score list"}
execute unless data storage reds_vehicles:definitions default_score_list[{name: "vehicle.nonstandard"}] run function rv_unittest:common/fail


#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
