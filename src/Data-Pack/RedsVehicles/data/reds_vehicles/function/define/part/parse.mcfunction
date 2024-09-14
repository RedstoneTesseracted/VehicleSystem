# This function is used to parse/validate a single part tag
# The part tag to parse/validate must be at "working_part"
# under the "reds_vehicles:definitions" storage
#
# The input tag is modified in-place, and converted to an
# entity-type spec
#
# Return 1 = Passed
# Return 0 = Failed

## PART INFORMATION ##
# Check for name field
execute unless data storage reds_vehicles:definitions working_part.name run function reds_vehicles:define/part/report/name_missing
execute unless data storage reds_vehicles:definitions working_part.name run return run function reds_vehicles:define/part/exit_fail

# Set "type" field to "item_display" to be compatible with entity spec
data modify storage reds_vehicles:definitions working_part.type set value "item_display"



## MODEL ##
# Check for required item field
execute unless data storage reds_vehicles:definitions working_part.item run function reds_vehicles:define/part/report/item_missing
execute unless data storage reds_vehicles:definitions working_part.item run return run function reds_vehicles:define/part/exit_fail

# Build up item tag field
data modify storage reds_vehicles:definitions new_item set value {id: "", components: {}}
data modify storage reds_vehicles:definitions new_item.id set from storage reds_vehicles:definitions working_part.item
execute if data storage reds_vehicles:definitions working_part.custom_model_data run data modify storage reds_vehicles:definitions new_item.components."minecraft:custom_model_data" set from storage reds_vehicles:definitions working_part.custom_model_data
data remove storage reds_vehicles:definitions working_part.custom_model_data
data modify storage reds_vehicles:definitions working_part.item set from storage reds_vehicles:definitions new_item
data remove storage reds_vehicles:definitions new_item



## MODEL TRANSFORMATIONS ##
# Remove "scale" and "translation" fields if "transform" is already provided
execute if data storage reds_vehicles:definitions working_part.transform run data remove storage reds_vehicles:definitions working_part.scale
execute if data storage reds_vehicles:definitions working_part.transform run data remove storage reds_vehicles:definitions working_part.translation

# Create "transform" field if it's not already provided (default to identity matrix)
execute unless data storage reds_vehicles:definitions working_part.transform run data modify storage reds_vehicles:definitions working_part.transform set value [1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f]

# Scale field (optional)
execute if data storage reds_vehicles:definitions working_part.scale[0] run data modify storage reds_vehicles:definitions working_part.transform[0] set from storage reds_vehicles:definitions working_part.scale[0]
execute if data storage reds_vehicles:definitions working_part.scale[1] run data modify storage reds_vehicles:definitions working_part.transform[5] set from storage reds_vehicles:definitions working_part.scale[1]
execute if data storage reds_vehicles:definitions working_part.scale[2] run data modify storage reds_vehicles:definitions working_part.transform[10] set from storage reds_vehicles:definitions working_part.scale[2]

# Translation field (optional)
execute if data storage reds_vehicles:definitions working_part.translation[0] run data modify storage reds_vehicles:definitions working_part.transform[3] set from storage reds_vehicles:definitions working_part.translation[0]
execute if data storage reds_vehicles:definitions working_part.translation[1] run data modify storage reds_vehicles:definitions working_part.transform[7] set from storage reds_vehicles:definitions working_part.translation[1]
execute if data storage reds_vehicles:definitions working_part.translation[2] run data modify storage reds_vehicles:definitions working_part.transform[11] set from storage reds_vehicles:definitions working_part.translation[2]



# Success!
return run function reds_vehicles:define/handling/exit_success

