#### UNIT TEST ####
# Try to declare a list of actions
data modify storage reds_vehicles:unittest name set value "parsing/handling_list/test_multiple"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare a list of default scores"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - ALL TAGS SPECIFIED, HIDE_PARTICLES=TRUE
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_handling_list set value []
data modify storage reds_vehicles:definitions working_handling_list append value {input: "look.y", operation: "increase", variable: "vehicle.dvel.y"}
data modify storage reds_vehicles:definitions working_handling_list append value {input: "look.x", operation: "decrease", variable: "vehicle.dvel.x"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/handling_list/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_handling_list[0] run data modify storage reds_vehicles:unittest reason set value {text:"working_handling_list was unexpectedly truncated to zero elements"}
execute unless data storage reds_vehicles:definitions working_handling_list[0] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_handling_list[1] run data modify storage reds_vehicles:unittest reason set value {text:"working_handling_list was unexpectedly truncated to one element"}
execute unless data storage reds_vehicles:definitions working_handling_list[1] run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_handling_list[2] run data modify storage reds_vehicles:unittest reason set value {text:"working_handling_list was somehow expanded past two elements"}
execute if data storage reds_vehicles:definitions working_handling_list[2] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_handling_list[{input: "look.y"}] run data modify storage reds_vehicles:unittest reason set value {text:"Dropped look.y handler"}
execute unless data storage reds_vehicles:definitions working_handling_list[{input: "look.y"}] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_handling_list[{input: "look.x"}] run data modify storage reds_vehicles:unittest reason set value {text:"Dropped look.x handler"}
execute unless data storage reds_vehicles:definitions working_handling_list[{input: "look.x"}] run return run function rv_unittest:common/fail


#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
