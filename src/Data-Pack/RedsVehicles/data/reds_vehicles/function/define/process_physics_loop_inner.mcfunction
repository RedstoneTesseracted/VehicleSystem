# This function recursively parses entries in the vehicle's physics list
#
# Before running this function, the contents of "working.physics" are copied to "unprocessed_physics"
# This function then pops and processes the first element of "unprocessed_physics" before running again
#
# It is called from reds_vehicles:define/process_physics_loop so that we can terminate early upon failure
# without interrupting the loop

# Type and value fields are always required
execute unless data storage reds_vehicles:definitions working_physics.type run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_physics_loop_inner', description: '[{"text":"Missing type field from physics tag"}]'}
execute unless data storage reds_vehicles:definitions working_physics.value run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_physics_loop_inner', description: '[{"text":"Missing value field from physics tag"}]'}
execute unless score vehicle.asserted_local vehicle.local matches 0 run return fail

# Try to lookup physics type to make sure it exists
data merge storage reds_vehicles:enums {args: {table: "physics"}}
data modify storage reds_vehicles:enums args.key set from storage reds_vehicles:definitions working_physics.type
execute store result score vehicle.physics_id vehicle.local run function reds_vehicles:define/enums/lookup_id with storage reds_vehicles:enums args
data remove storage reds_vehicles:enums args

# The lookup function should NEVER return a zero unless it failed to compile
execute if score vehicle.physics_id vehicle.local matches 0 run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_physics_loop_inner', description: '[{"text":"An unknown error occurred while looking up the physics type that caused the macro in reds_vehicles:define/enums/lookup_id to fail.  Please double-check your physics type; valid physics types are: gravity, buoyant, simple_lift, and planar_drag"}]'}
execute if score vehicle.physics_id vehicle.local matches 0 run return fail

# Invalid type
execute if score vehicle.physics_id vehicle.local matches -1 run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_physics_loop_inner', description: '[{"text":"Encountered an unrecognized physics type.  Valid physics types are: gravity, buoyant, simple_lift, and planar_drag"}]'}
execute if score vehicle.physics_id vehicle.local matches -1 run return fail

# Type gravity - handle specially
execute if score vehicle.physics_id vehicle.local matches 1 run data modify storage reds_vehicles:definitions working.base_gravity set from storage reds_vehicles:definitions working_physics.value
# Type buoyant - has an extra field "environment"
execute if score vehicle.physics_id vehicle.local matches 2 run function reds_vehicles:define/assert_buoyant_valid
execute unless score vehicle.asserted_local vehicle.local matches 0 run return fail
# Type simple_lift - fine as-is
# Type planar_drag - fine as-is


# Only add physics tag to final result if valid AND not gravity
execute unless score vehicle.physics_id vehicle.local matches 1 if score vehicle.asserted_local vehicle.local matches 0 run data modify storage reds_vehicles:definitions processed_physics append from storage reds_vehicles:definitions working_physics
