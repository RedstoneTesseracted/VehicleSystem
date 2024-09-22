#### UNIT TEST ####
data modify storage reds_vehicles:unittest name set value "parsing/part_list/test_multiple"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare a list of default scores"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - ALL TAGS SPECIFIED, HIDE_PARTICLES=TRUE
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_part_list set value []
data modify storage reds_vehicles:definitions working_part_list append value {name: "display.inner", item: "minecraft:glass", scale:[-4.0f,-4.0f,-4.0f]}
data modify storage reds_vehicles:definitions working_part_list append value {name: "display.outer", item: "minecraft:glass", scale:[4.0f,4.0f,4.0f]}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/part_list/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_part_list[0] run data modify storage reds_vehicles:unittest reason set value {text:"working_part_list was unexpectedly truncated to zero elements"}
execute unless data storage reds_vehicles:definitions working_part_list[0] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_part_list[1] run data modify storage reds_vehicles:unittest reason set value {text:"working_part_list was unexpectedly truncated to one element"}
execute unless data storage reds_vehicles:definitions working_part_list[1] run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_part_list[2] run data modify storage reds_vehicles:unittest reason set value {text:"working_part_list was somehow expanded past two elements"}
execute if data storage reds_vehicles:definitions working_part_list[2] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_part_list[{name: "display.inner"}] run data modify storage reds_vehicles:unittest reason set value {text:"display.inner was dropped from working_part_list"}
execute unless data storage reds_vehicles:definitions working_part_list[{name: "display.inner"}] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_part_list[{name: "display.outer"}] run data modify storage reds_vehicles:unittest reason set value {text:"display.outer was dropped from working_part_list"}
execute unless data storage reds_vehicles:definitions working_part_list[{name: "display.outer"}] run return run function rv_unittest:common/fail


#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
