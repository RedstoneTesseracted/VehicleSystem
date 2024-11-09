#### UNIT TEST ####
data modify storage reds_vehicles:unittest name set value "parsing/action/message/test_valid_input"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare a message action using valid input"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - VALID INPUT
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_action set value {action: "message", arguments:{text: {text:"Hello world!"}}}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/action/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_action{action: "message"} run data modify storage reds_vehicles:unittest reason set value [{text:"working_action.action was somehow converted to \""},{nbt:"working_action.action", storage:"reds_vehicles:definitions"},{text:"\""}]
execute unless data storage reds_vehicles:definitions working_action{action: "message"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_action.arguments{text:{text:"Hello world!"}} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_action.action.text to be {text:\"Hello world!\"} (was "},{nbt:"working_action.action.text", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_action.arguments{text:{text:"Hello world!"}} run return run function rv_unittest:common/fail


#####################################################################################################


# Everything passed!
return run function rv_unittest:common/pass
