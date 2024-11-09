# This function is used to parse/validate a single physics tag
# The physics tag to parse/validate must be at "working_physics"
# under the "reds_vehicles:definitions" storage
#
# The input tag is modified in-place
#
# Return 1 = Passed
# Return 0 = Failed

# Type field is required
execute unless data storage reds_vehicles:definitions working_physics.type run function reds_vehicles:define/physics/report/type_missing
execute unless data storage reds_vehicles:definitions working_physics.type run return run function reds_vehicles:define/physics/exit_fail

# Perform type-specific validation
scoreboard players set vehicle.physics_type_exists vehicle.local 0
execute store result score vehicle.physics_macro_status vehicle.local run function reds_vehicles:define/physics/parse_type_specific with storage reds_vehicles:definitions working_physics
execute if score vehicle.physics_macro_status vehicle.local matches 0 run function reds_vehicles:define/physics/report/type_macro_fail
execute if score vehicle.physics_macro_status vehicle.local matches 0 run function reds_vehicles:define/physics/exit_fail
execute unless score vehicle.physics_macro_status vehicle.local matches 1 if score vehicle.physics_type_exists vehicle.local matches 0 run function reds_vehicles:define/physics/report/type_invalid
execute unless score vehicle.physics_macro_status vehicle.local matches 1 run return run function reds_vehicles:define/physics/exit_fail

# Assign UID to prevent conflicts between multiple entries of the same type
execute store result storage reds_vehicles:definitions working_physics.uid int 1 run random value 0..2147483646

# Process predicates list
data modify storage reds_vehicles:definitions working_predicate set value ""
data modify storage reds_vehicles:definitions working_predicates set from storage reds_vehicles:definitions working_physics.predicates
execute unless data storage reds_vehicles:definitions working_physics.predicates run data modify storage reds_vehicles:definitions working_predicates set value []
execute unless function reds_vehicles:define/predicate_list/parse run return run function reds_vehicles:define/physics/exit_fail
data modify storage reds_vehicles:definitions working_physics.predicate set from storage reds_vehicles:definitions working_predicate
data remove storage reds_vehicles:definitions working_predicates
data remove storage reds_vehicles:definitions working_physics.predicates

# Success!
return run function reds_vehicles:define/physics/exit_success
