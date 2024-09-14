# This function is used to parse/validate a single event tag
# The event tag to parse/validate must be at "working_event"
# under the "reds_vehicles:definitions" storage
#
# The input tag is modified in-place
#
# Return 1 = Passed
# Return 0 = Failed
#
# Fields:
#   trigger (str, optional)
#   predicates (list, optional)
#   actions (list, required)

# Initialize the /execute condition
data modify storage reds_vehicles:definitions working_event.predicate set value ""

# Add trigger into condition, if provided
execute if data storage reds_vehicles:definitions working_event.trigger store result score vehicle.trigger_macro_status vehicle.local run function reds_vehicles:define/event/generate_trigger_condition with storage reds_vehicles:definitions working_event
execute if data storage reds_vehicles:definitions working_event.trigger if score vehicle.trigger_macro_status vehicle.local matches 0 run function reds_vehicles:define/event/report/trigger_macro_fail
execute if data storage reds_vehicles:definitions working_event.trigger if score vehicle.trigger_macro_status vehicle.local matches 0 run return run function reds_vehicles:define/event/exit_fail
data remove storage reds_vehicles:definitions working.trigger

# Process predicates list
data modify storage reds_vehicles:definitions working_predicate set value ""
data modify storage reds_vehicles:definitions working_predicates set from storage reds_vehicles:definitions working_event.predicates
execute unless data storage reds_vehicles:definitions working_event.predicates run data modify storage reds_vehicles:definitions working_predicates set value []
execute unless function reds_vehicles:define/predicate_list/parse run return run function reds_vehicles:define/physics/exit_fail
data remove storage reds_vehicles:definitions working_event.predicates

# Append the result from the predicates list
data modify storage reds_vehicles:definitions event_args.working set from storage reds_vehicles:definitions working_event.predicate
data modify storage reds_vehicles:definitions event_args.append set from storage reds_vehicles:definitions working_predicate
execute store result score vehicle.join_macro_status vehicle.local run function reds_vehicles:define/event/join_conditions with storage reds_vehicles:definitions event_args
execute unless score vehicle.join_macro_status vehicle.local matches 1 run function reds_vehicles:define/event/report/join_macro_fail
execute unless score vehicle.join_macro_status vehicle.local matches 1 run return run function reds_vehicles:define/event/exit_fail

# Parse actions list (required)
execute unless data storage reds_vehicles:definitions working_event.actions run function reds_vehicles:define/event/report/missing_actions
execute unless data storage reds_vehicles:definitions working_event.actions run return run function reds_vehicles:define/event/exit_fail
execute store result score vehicle.action_list_length vehicle.local run data get storage reds_vehicles:definitions working_event.actions
execute if score vehicle.action_list_length vehicle.local matches 0 run function reds_vehicles:define/event/report/zero_actions
execute if score vehicle.action_list_length vehicle.local matches 0 run function reds_vehicles:define/event/exit_fail

data modify storage reds_vehicles:definitions working_action_list set from storage reds_vehicles:definitions working_event.actions
execute unless function reds_vehicles:define/action_list/parse run return run function reds_vehicles:define/event/exit_fail
data modify storage reds_vehicles:definitions working_event.actions set from storage reds_vehicles:definitions working_action_list

# Success!
return run function reds_vehicles:define/event/exit_success

