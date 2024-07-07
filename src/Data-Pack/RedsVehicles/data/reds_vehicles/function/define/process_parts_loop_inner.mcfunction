# This function recursively parses entries in the vehicle's parts list
#
# Before running this function, the contents of "working.parts" are copied to "unprocessed_parts"
# This function then pops and processes the first element of "unprocessed_parts" before running again
#
# It is called from reds_vehicles:define/process_parts_loop so that we can terminate early upon failure
# without interrupting the loop

data merge storage reds_vehicles:definitions {working_entity: {type: "item_display"}}

# Check for required fields (item, model, name)
execute unless data storage reds_vehicles:definitions working_part.item run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_parts_loop_inner', description: '[{"text":"Missing item field from parts tag"}]'}
execute unless data storage reds_vehicles:definitions working_part.item run return fail
data modify storage reds_vehicles:definitions working_entity.item set from storage reds_vehicles:definitions working_part.item

execute unless data storage reds_vehicles:definitions working_part.model run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_parts_loop_inner', description: '[{"text":"Missing item field from parts tag"}]'}
execute unless data storage reds_vehicles:definitions working_part.model run return fail
data modify storage reds_vehicles:definitions working_entity.model set from storage reds_vehicles:definitions working_part.model

execute unless data storage reds_vehicles:definitions working_part.name run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_parts_loop_inner', description: '[{"text":"Missing item field from parts tag"}]'}
execute unless data storage reds_vehicles:definitions working_part.name run return fail
data modify storage reds_vehicles:definitions working_entity.name set from storage reds_vehicles:definitions working_part.name


# Set default display transform
data modify storage reds_vehicles:definitions working_entity.transform set value [1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f]

# Set transform based on optional scale and translation tags
execute if data storage reds_vehicles:definitions working_part.scale[0] run data modify storage reds_vehicles:definitions working_entity.transform[0] set from storage reds_vehicles:definitions working_part.scale[0]
execute if data storage reds_vehicles:definitions working_part.scale[1] run data modify storage reds_vehicles:definitions working_entity.transform[5] set from storage reds_vehicles:definitions working_part.scale[1]
execute if data storage reds_vehicles:definitions working_part.scale[2] run data modify storage reds_vehicles:definitions working_entity.transform[10] set from storage reds_vehicles:definitions working_part.scale[2]

execute if data storage reds_vehicles:definitions working_part.translation[0] run data modify storage reds_vehicles:definitions working_entity.transform[3] set from storage reds_vehicles:definitions working_part.translation[0]
execute if data storage reds_vehicles:definitions working_part.translation[1] run data modify storage reds_vehicles:definitions working_entity.transform[7] set from storage reds_vehicles:definitions working_part.translation[1]
execute if data storage reds_vehicles:definitions working_part.translation[2] run data modify storage reds_vehicles:definitions working_entity.transform[11] set from storage reds_vehicles:definitions working_part.translation[2]


# Override transform based on optional transform tag
execute store result score vehicle.transform_array_length vehicle.local run data get storage reds_vehicles:definitions working_part.transform
execute if data storage reds_vehicles:definitions working_part.transform unless score vehicle.transform_array_length vehicle.local matches 16 run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_parts_loop_inner', description: '[{"text":"Got incorrect size for display transformation array; expected a length of 16"}]'}
execute if data storage reds_vehicles:definitions working_part.transform unless score vehicle.transform_array_length vehicle.local matches 16 run return fail
execute if data storage reds_vehicles:definitions working_part.transform run data modify storage reds_vehicles:definitions working_entity.transform set from storage reds_vehicles:definitions working_part.transform


# Add entity to list
data modify storage reds_vehicles:definitions working.entities append from storage reds_vehicles:definitions working_entity
