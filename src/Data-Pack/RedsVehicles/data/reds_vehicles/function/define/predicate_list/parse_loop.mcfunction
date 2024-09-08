# This function handles the looping aspect of reds_vehicles:define/predicate_list/parse

# Pop the first element in the list
data modify storage reds_vehicles:definitions predicate_args.append set from storage reds_vehicles:definitions unprocessed_predicates[0]
data remove storage reds_vehicles:definitions unprocessed_predicates[0]

# Execute the function macro
execute store result score vehicle.concat_macro_status vehicle.local run function reds_vehicles:define/predicate_list/__parse_loop with storage reds_vehicles:definitions predicate_args

# Handle macro failure
execute if score vehicle.concat_macro_status vehicle.local matches 0 run function reds_vehicles:define/predicate_list/report/macro_fail
execute if score vehicle.concat_macro_status vehicle.local matches 0 run return 0

# Run again if elements remain
# Otherwise, return a success!
execute if data storage reds_vehicles:definitions unprocessed_predicates[0] run return run function reds_vehicles:define/predicate_list/parse_loop
return 1
