# This function joins a physics tag's predicate list into a single statement 
# compatible with the /execute command
#
# It is called from reds_vehicles:define/process_physics_loop_inner

# Copy the list into a temporary buffer and set up output storage
data modify storage reds_vehicles:definitions predicate_args set value {working: "", append: ""}

# Run the looping function
execute if data storage reds_vehicles:definitions working_physics.predicates[0] unless function reds_vehicles:define/process_physics_predicates_loop run return fail

# Clean up storage
data remove storage reds_vehicles:definitions working_physics.predicates
data modify storage reds_vehicles:definitions working_physics.predicate set from storage reds_vehicles:definitions predicate_args.working
data remove storage reds_vehicles:definitions predicate_args

# Return success
return 1
