# This function recursively parses entries in the vehicle's events list
#
# Before running this function, the contents of "working.events" are copied to "unprocessed_events"
# This function then pops and processes the first element of "unprocessed_events" before running again
#
# It is called from reds_vehicles:define/process_events_loop so that we can terminate early upon failure
# without interrupting the loop

# Fields:
#   trigger (str, optional)
#   predicates (list, optional)
#   actions (list, required)

# Initialize /execute condition
data modify storage reds_vehicles:definitions predicate set value ""

# Add trigger into condition, if specified
execute if data storage reds_vehicles:definitions working_event.trigger store result score vehicle.success vehicle.local run function reds_vehicles:define/__process_events_loop_inner_append_trigger with storage reds_vehicles:definitions working_event
execute if data storage reds_vehicles:definitions working_event.trigger if score vehicle.success vehicle.local matches 0 run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_events_loop_inner', description: '[{"text":"An unknown error occurred that caused the macro in reds_vehicles:define/__process_events_loop_inner_append_trigger to fail.  Either there’s a bug in the macro or an invalid trigger string was provided"}]'}
execute if data storage reds_vehicles:definitions working_event.trigger if score vehicle.success vehicle.local matches 0 run return fail

# Process predicates list, if specified
data modify storage reds_vehicles:definitions compiled_predicate set value ""
execute if data storage reds_vehicles:definitions working_event.predicates[0] run data modify storage reds_vehicles:definitions unprocessed_predicates set from storage reds_vehicles:definitions working_event.predicates
execute if data storage reds_vehicles:definitions working_event.predicates[0] unless function reds_vehicles:define/process_generic_predicates run return fail
data remove storage reds_vehicles:definitions unprocessed_predicates

data modify storage reds_vehicles:definitions args.predicate set from storage reds_vehicles:definitions predicate
data modify storage reds_vehicles:definitions args.compiled_predicate set from storage reds_vehicles:definitions compiled_predicate
execute if data storage reds_vehicles:definitions working_event.predicates[0] store result score vehicle.success vehicle.local run function reds_vehicles:define/__process_events_loop_inner_append_compiled_predicate with storage reds_vehicles:definitions args
execute if data storage reds_vehicles:definitions working_event.predicates[0] if score vehicle.success vehicle.local matches 0 run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_events_loop_inner', description: '[{"text":"An unknown error occurred that caused the macro in reds_vehicles:define/__process_events_loop_inner_append_compiled_predicate to fail.  This is most likely a bug in the macro"}]'}
execute if data storage reds_vehicles:definitions working_event.predicates[0] if score vehicle.success vehicle.local matches 0 run return fail
data remove storage reds_vehicles:definitions args
data remove storage reds_vehicles:definitions compiled_predicate

# Add compiled predicate string into vehicle definition and clean up
data modify storage reds_vehicles:definitions working_event.predicate set from storage reds_vehicles:definitions predicate
data remove storage reds_vehicles:definitions predicate


# Validate actions list
execute unless data storage reds_vehicles:definitions working_event.actions run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_events_loop_inner', description: '[{"text":"Missing actions field from event tag"}]'}
execute unless score vehicle.asserted_local vehicle.local matches 0 run return fail
execute unless data storage reds_vehicles:definitions working_event.actions[0] run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_events_loop_inner', description: '[{"text":"Event tag’s actions list must have nonzero length"}]'}
execute unless score vehicle.asserted_local vehicle.local matches 0 run return fail

data modify storage reds_vehicles:definitions unprocessed_actions set from storage reds_vehicles:definitions working_event.actions
data modify storage reds_vehicles:definitions processed_actions set value []
execute unless function reds_vehicles:define/process_actions_loop run return fail
data modify storage reds_vehicles:definitions working_event.actions set from storage reds_vehicles:definitions processed_actions

data remove storage reds_vehicles:definitions unprocessed_actions
data remove storage reds_vehicles:definitions processed_actions

# Add final working event to processed list
data modify storage reds_vehicles:definitions processed_events append from storage reds_vehicles:definitions working_event
data remove storage reds_vehicles:definitions working_event
