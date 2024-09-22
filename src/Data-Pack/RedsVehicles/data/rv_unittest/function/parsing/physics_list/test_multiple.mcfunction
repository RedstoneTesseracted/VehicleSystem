#### UNIT TEST ####
data modify storage reds_vehicles:unittest name set value "parsing/physics_list/test_multiple"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare a list of physics tags"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup
data merge storage reds_vehicles:definitions {vehicles:[],processed:[],working_gravity:0.0f}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_physics_list set value []
data modify storage reds_vehicles:definitions working_physics_list append value {type: "gravity", value: 0.16}
data modify storage reds_vehicles:definitions working_physics_list append value {type: "applied", value: 1.0}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/physics_list/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_physics_list[0] run data modify storage reds_vehicles:unittest reason set value {text:"working_physics_list was unexpectedly truncated to zero elements"}
execute unless data storage reds_vehicles:definitions working_physics_list[0] run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_physics_list[{type:"gravity"}] run data modify storage reds_vehicles:unittest reason set value {text:"\"gravity\" was not dropped from working_physics_list"}
execute if data storage reds_vehicles:definitions working_physics_list[{type:"gravity"}] run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_physics_list[1] run data modify storage reds_vehicles:unittest reason set value {text:"working_physics_list was somehow expanded past one element"}
execute if data storage reds_vehicles:definitions working_physics_list[1] run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions {working_gravity:0.16} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_gravity to be 0.16 (was "},{nbt:"working_gravity", storage:"reds_vehicles:definitions"},{text:")"}]
execute if data storage reds_vehicles:definitions {working_gravity:0.16} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_physics_list[{type:"applied"}] run data modify storage reds_vehicles:unittest reason set value {text:"applied force was dropped from working_physics_list"}
execute unless data storage reds_vehicles:definitions working_physics_list[{type:"applied"}] run return run function rv_unittest:common/fail


#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
