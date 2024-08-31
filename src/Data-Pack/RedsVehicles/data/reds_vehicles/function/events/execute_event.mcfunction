# This function is run when an event is executed
# It is responsible for executing all defined actions
# for the event
#
# It is called from reds_vehicles:events/try_event_loop whenever
# all conditions for an event pass

# Copy over the actions list to a temporary buffer
data modify storage reds_vehicles:events unapplied_actions set from storage reds_vehicles:events unchecked_events[0].actions

# Run loop
function reds_vehicles:events/action_loop with storage reds_vehicles:events unapplied_actions[0]

# Clean up temporary storage
data remove storage reds_vehicles:events unapplied_actions
