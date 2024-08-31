# This function uses a recursion-based loop to iterate over a list of predicates
#
# It is called from reds_vehicles:define/process_generic_predicates, which
# performs some set-up

# Prepare arguments
data modify storage reds_vehicles:definitions predicate_args.append set from storage reds_vehicles:definitions unprocessed_predicates[0]

# Append next predicate
execute store result score vehicle.macro_ok_flag vehicle.local run function reds_vehicles:define/__process_generic_predicates_loop with storage reds_vehicles:definitions predicate_args
execute unless score vehicle.macro_ok_flag vehicle.local matches 1 run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_generic_predicates_loop', description: '[{"text":"An unknown error occurred that caused the macro in reds_vehicles:define/__process_generic_predicates_loop to fail.  Either there’s a bug in the macro or an invalid string was provided"}]'}
execute unless score vehicle.macro_ok_flag vehicle.local matches 1 run return fail

# Remove element and run again if any remain
data remove storage reds_vehicles:definitions unprocessed_predicates
execute if data storage reds_vehicles:definitions unprocessed_predicates run return run function reds_vehicles:define/process_generic_predicates_loop

# Return success
return 1
