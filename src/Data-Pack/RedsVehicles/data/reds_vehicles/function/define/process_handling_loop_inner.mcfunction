# This function recursively parses/validates entries in the working vehicle's handling list
#
# Before running this function, the contents of "working.handling" are copied to "unprocessed_handling"
# This function then pops and processes the first element of "unprocessed_handling" before running again
#
# It is called from reds_vehicles:define/process_handling_loop to allow us to return on error without breaking the loop

# Check for all required fields
# Input field
execute unless data storage reds_vehicles:definitions working_handling.input run function reds_vehicles:define/assert_working_fail {source: 'reds_vehicles:define/process_handling_loop_inner', description: '[{"text":"Missing input field in handling tag"}]'}
execute unless data storage reds_vehicles:definitions working_handling.input run return fail
# Operation field
execute unless data storage reds_vehicles:definitions working_handling.operation run function reds_vehicles:define/assert_working_fail {source: 'reds_vehicles:define/process_handling_loop_inner', description: '[{"text":"Missing operation field in handling tag"}]'}
execute unless data storage reds_vehicles:definitions working_handling.operation run return fail
# Variable field
execute unless data storage reds_vehicles:definitions working_handling.variable run function reds_vehicles:define/assert_working_fail {source: 'reds_vehicles:define/process_handling_loop_inner', description: '[{"text":"Missing variable field in handling tag"}]'}
execute unless data storage reds_vehicles:definitions working_handling.variable run return fail

# Scale field (optional, defaults to no scale)
execute unless data storage reds_vehicles:definitions working_handling.scale run data modify storage reds_vehicles:definitions working_handling.scale set value {source:"none"}

# Scale source field (should be present by now, even if scale tag wasn't provided)
execute unless data storage reds_vehicles:definitions working_handling.scale.source run function reds_vehicles:define/assert_working_fail {source: 'reds_vehicles:define/process_handling_loop_inner', description: '[{"text":"Missing source field in handling tag’s scale compound"}]'}
execute unless data storage reds_vehicles:definitions working_handling.scale.source run return fail

# Scale score_scale field (optional, defaults to 1.0)
execute unless data storage reds_vehicles:definitions working_handling.scale.score_scale run data modify storage reds_vehicles:definitions working_handling.scale.score_scale set value 1.0

# Precision field (optional, defaults to 1)
execute unless data storage reds_vehicles:definitions working_handling.precision run data modify storage reds_vehicles:definitions working_handling.precision set value 1



# Validate input field by getting its numeric ID
data merge storage reds_vehicles:enums {args: {table: "inputs"}}
data modify storage reds_vehicles:enums args.key set from storage reds_vehicles:definitions working_handling.input
execute store result score vehicle.input_id vehicle.local run function reds_vehicles:define/enums/lookup_id with storage reds_vehicles:enums args

# The lookup function should NEVER return a zero unless it failed to compile
execute if score vehicle.input_id vehicle.local matches 0 run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_handling_loop_inner', description: '[{"text":"An unknown error occurred while looking up the input type that caused the macro in reds_vehicles:define/enums/lookup_id to fail.  Either there’s a bug in the macro or an invalid string was provided"}]'}
execute if score vehicle.input_id vehicle.local matches 0 run return fail
# Invalid type
execute if score vehicle.input_id vehicle.local matches -1 run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_handling_loop_inner', description: '[{"text":"Encountered an unrecognized input type.  See documentation for list of input types."}]'}
execute if score vehicle.input_id vehicle.local matches -1 run return fail


# Obtain the corresponding group
execute store success score vehicle.success vehicle.local run function reds_vehicles:define/enums/lookup_group with storage reds_vehicles:enums args
data remove storage reds_vehicles:enums args
# Failed to compile (somehow?)
execute if score vehicle.success vehicle.local matches 0 run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_handling_loop_inner', description: '[{"text":"An unknown error occurred while looking up the input group that caused the macro in reds_vehicles:define/enums/lookup_group to fail.  If we’ve made it this far, the input type is probably fine and something else is causing problems."}]'}
execute if score vehicle.success vehicle.local matches 0 run return fail
# Mark the corresponding group flag
data modify storage reds_vehicles:enums args.group set from storage reds_vehicles:definitions returned_group
execute store success score vehicle.success vehicle.local run function reds_vehicles:define/__process_handling_loop_inner with storage reds_vehicles:enums args
data remove storage reds_vehicles:enums args
execute if score vehicle.success vehicle.local matches 0 run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_handling_loop_inner', description: '[{"text":"An unknown error occurred that caused the macro reds_vehicles:define/__process_handling_loop_inner to fail.  This is probably a bug with the pack."}]'}
execute if score vehicle.success vehicle.local matches 0 run return fail


# Validate scale fields
# First, validate scale.source by getting its numeric ID
data merge storage reds_vehicles:enums {args: {table: "scale_source"}}
data modify storage reds_vehicles:enums args.key set from storage reds_vehicles:definitions working_handling.scale.source
execute store result score vehicle.source_id vehicle.local run function reds_vehicles:define/enums/lookup_id with storage reds_vehicles:enums args
# Compile fail
execute if score vehicle.source_id vehicle.local matches 0 run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_handling_loop_inner', description: '[{"text":"An unknown error occurred while looking up the scale source type that caused the macro in reds_vehicles:define/enums/lookup_id to fail.  Either there’s a bug in the macro or an invalid string was provided"}]'}
execute if score vehicle.source_id vehicle.local matches 0 run return fail
# Invalid type
execute if score vehicle.source_id vehicle.local matches -1 run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_handling_loop_inner', description: '[{"text":"Encountered an unrecognized scale source type; valid scale sources are constant and score"}]'}
execute if score vehicle.source_id vehicle.local matches -1 run return fail

# Make sure we have the corresponding fields for this source type
# Constant - requires value
execute if score vehicle.source_id vehicle.local matches 1 unless data storage reds_vehicles:definitions working_handling.scale.value run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_handling_loop_inner', description: '[{"text":"Missing required “value” field for source type “constant”"}]'}
execute if score vehicle.source_id vehicle.local matches 1 unless data storage reds_vehicles:definitions working_handling.scale.value run return fail

# Score - requires name
execute if score vehicle.source_id vehicle.local matches 2 unless data storage reds_vehicles:definitions working_handling.scale.name run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_handling_loop_inner', description: '[{"text":"Missing required “name” field for source type “score”"}]'}
execute if score vehicle.source_id vehicle.local matches 2 unless data storage reds_vehicles:definitions working_handling.scale.name run return fail

# None - no required values

