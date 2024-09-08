# This function uses macros and a recursion-based loop to join a 
# list of predicates together
#
# The list of predicates must be stored in "working_predicates" 
# under the "reds_vehicles:definitions" storage.
#
# The output is a /execute-compatible string containing all
# predicates.  Said output is stored in "working_predicate"

# Set "working_predicate" if it's not already set
execute unless data storage reds_vehicles:definitions working_predicate run data modify storage reds_vehicles:definitions working_predicate set value ""

# Set up temporary storage
data modify storage reds_vehicles:definitions predicate_args set value {working: "", append: ""}
data modify storage reds_vehicles:definitions unprocessed_predicates set from storage reds_vehicles:definitions working_predicates
execute if data storage reds_vehicles:definitions unprocessed_predicates[0] unless function reds_vehicles:define/predicate_list/parse_loop run return run function reds_vehicles:define/predicate_list/exit_fail

# Write to output
data modify storage reds_vehicles:definitions working_predicate set from storage reds_vehicles:definitions predicate_args.working

# Success!
return run function reds_vehicles:define/predicate_list/exit_success
