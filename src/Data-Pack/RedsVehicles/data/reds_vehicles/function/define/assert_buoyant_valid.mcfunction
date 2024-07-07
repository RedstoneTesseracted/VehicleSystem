# This function makes sure the required fields for the buoyancy physics type are present in the tag
# This is called from reds_vehicles:define/process_physics_loop when the physics type is "buouyant"

# "environment" tag is required
execute unless data storage reds_vehicles:definitions working_physics.environment run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_physics_loop', description: '[{"text":"Buoyancy physics tag missing environment field"}]'}
execute unless data storage reds_vehicles:definitions working_physics.environment run return fail

# Look up ID
data merge storage reds_vehicles:enums {args: {table: "environment"}}
data modify storage reds_vehicles:enums args.key set from storage reds_vehicles:definitions working_physics.environment
execute store result score vehicle.environment_id vehicle.local run function reds_vehicles:define/enums/lookup_id with storage reds_vehicles:enums args

# The lookup function should NEVER return a zero unless it failed to compile
execute if score vehicle.environment_id vehicle.local matches 0 run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_physics_loop', description: '[{"text":"An unknown error occurred while looking up the environment type that caused the macro in reds_vehicles:define/enums/lookup_id to fail.  Either there’s a bug in the macro or an invalid string was provided"}]'}
execute if score vehicle.environment_id vehicle.local matches 0 run return fail
execute if score vehicle.environment_id vehicle.local matches -1 run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_physics_loop', description: '[{"text":"Buoyancy physics tag was provided an unknown environment type.  Valid environment types are: water, lava, and air"}]'}
execute if score vehicle.environment_id vehicle.local matches -1 run return fail
