# This function joins the entries in a predicate list into a single statement 
# compatible with the /execute command.
#
# It requires the predicates list to have been stored to `unprocessed_predicates`
# under `reds_vehicles:definitions` externally.
#
# The final compiled predicate is stored to `compiled_predicate` under 
# `reds_vehicles:definitions`.
#
# Several places call this function, including:
#   reds_vehicles:define/process_physics_loop_inner

# Set up storage
data modify storage reds_vehicles:definitions predicate_args set value {working: "", append: ""}

# Run the looping function
execute if data storage reds_vehicles:definitions unprocessed_predicates[0] unless function reds_vehicles:define/process_generic_predicates_loop run return fail

# Clean up storage
data modify storage reds_vehicles:definitions compiled_predicate set from storage reds_vehicles:definitions predicate_args.working
data remove storage reds_vehicles:definitions unprocessed_predicates
data remove storage reds_vehicles:definitions predicate_args

# Return success
return 1
