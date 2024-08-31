# This function concatenates two strings to help build up the full predicate
# It is called by reds_vehicles:define/process_generic_predicates_loop
$data modify storage reds_vehicles:definitions predicate_args.working set value "$(working)if predicate $(append) "
return 1
