#### UNIT TEST ####
data modify storage reds_vehicles:unittest name set value "parsing/part/test_valid_input"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare an part element using valid input"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup - FULL
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_part set value {name: "display", groups: ["foo", "bar"], scale: [1.0f, 2.0f, 3.0f], translation: [4.0f, 5.0f, 6.0f], item: "minecraft:glass", model: "reds_vehicles:vehicles/test"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/part/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_part{name: "display"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_part.name to be \"display\" (was "},{nbt:"working_part.name", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_part{name: "display"} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_part.groups run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_part.groups to have been removed"}
execute if data storage reds_vehicles:definitions working_part.groups run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_part{extra_tags:["vehicle.group.foo", "vehicle.group.bar"]} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_part.extra_tags to be [\"vehicle.group.foo\", \"vehicle.group.bar\"] (was "},{nbt:"working_part.extra_tags", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_part{extra_tags:["vehicle.group.foo", "vehicle.group.bar"]} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_part{transform: [1.0f, 0.0f, 0.0f, 4.0f, 0.0f, 2.0f, 0.0f, 5.0f, 0.0f, 0.0f, 3.0f, 6.0f, 0.0f, 0.0f, 0.0f, 1.0f]} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_part.transform to be [1.0f, 0.0f, 0.0f, 4.0f, 0.0f, 2.0f, 0.0f, 5.0f, 0.0f, 0.0f, 3.0f, 6.0f, 0.0f, 0.0f, 0.0f, 1.0f] (was "},{nbt:"working_part.transform", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_part{transform: [1.0f, 0.0f, 0.0f, 4.0f, 0.0f, 2.0f, 0.0f, 5.0f, 0.0f, 0.0f, 3.0f, 6.0f, 0.0f, 0.0f, 0.0f, 1.0f]} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_part.translation run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_part.translation to have been removed"}
execute if data storage reds_vehicles:definitions working_part.translation run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_part.scale run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_part.translation to have been removed"}
execute if data storage reds_vehicles:definitions working_part.scale run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_part.item{id: "minecraft:glass"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_part.item.id to be \"minecraft:glass\" (was "},{nbt:"working_part.item.id", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_part.item{id: "minecraft:glass"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_part.item.components{"minecraft:item_model": "reds_vehicles:vehicles/test"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_part.item.components.\"minecraft:item_model\" to be \"reds_vehicles:vehicles/test\" (was "},{nbt:"working_part.item.components.\"minecraft:item_model\"", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_part.item.components{"minecraft:item_model": "reds_vehicles:vehicles/test"} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_part.model run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_part.model to have been removed"}
execute if data storage reds_vehicles:definitions working_part.model run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_part{type: "item_display"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_part.type to be \"item_display\" (was "},{nbt:"working_part.type", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_part{type: "item_display"} run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - OPTIONAL VALUES ABSENT
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_part set value {name: "display.outer", item: "minecraft:stone"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/part/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_part{name: "display.outer"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_part.name to be \"display\" (was "},{nbt:"working_part.name", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_part{name: "display.outer"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_part{transform: [1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f]} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_part.transform to be [1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f] (was "},{nbt:"working_part.transform", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_part{transform: [1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f]} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_part.translation run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_part.translation to have been removed"}
execute if data storage reds_vehicles:definitions working_part.translation run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_part.scale run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_part.translation to have been removed"}
execute if data storage reds_vehicles:definitions working_part.scale run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_part.item{id: "minecraft:stone"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_part.item.id to be \"minecraft:glass\" (was "},{nbt:"working_part.item.id", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_part.item{id: "minecraft:stone"} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_part.model run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_part.model to have been removed"}
execute if data storage reds_vehicles:definitions working_part.model run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_part{type: "item_display"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_part.type to be \"item_display\" (was "},{nbt:"working_part.type", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_part{type: "item_display"} run return run function rv_unittest:common/fail

#####################################################################################################

# Setup - TRANSFORM OVERRIDE
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

data modify storage reds_vehicles:definitions working_part set value {name: "display.outer", scale: [1.0f, 2.0f, 3.0f], translation: [4.0f, 5.0f, 6.0f], transform: [1.0f, 0.0f, 0.0f, 4.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f], item: "minecraft:glass"}

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/part/parse

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_part{name: "display.outer"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_part.name to be \"display.outer\" (was "},{nbt:"working_part.name", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_part{name: "display.outer"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_part{transform: [1.0f, 0.0f, 0.0f, 4.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f]} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_part.transform to be [1.0f, 0.0f, 0.0f, 4.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f] (was "},{nbt:"working_part.transform", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_part{transform: [1.0f, 0.0f, 0.0f, 4.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f]} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_part.translation run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_part.translation to have been removed"}
execute if data storage reds_vehicles:definitions working_part.translation run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_part.scale run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_part.translation to have been removed"}
execute if data storage reds_vehicles:definitions working_part.scale run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_part.item{id: "minecraft:glass"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_part.item.id to be \"minecraft:glass\" (was "},{nbt:"working_part.item.id", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_part.item{id: "minecraft:glass"} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_part.model run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_part.model to have been removed"}
execute if data storage reds_vehicles:definitions working_part.model run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_part{type: "item_display"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_part.type to be \"item_display\" (was "},{nbt:"working_part.type", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_part{type: "item_display"} run return run function rv_unittest:common/fail

#####################################################################################################



# Everything passed!
return run function rv_unittest:common/pass
