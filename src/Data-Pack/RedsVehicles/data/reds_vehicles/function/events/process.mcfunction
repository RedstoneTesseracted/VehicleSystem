# This functions handles the triggering/application of events
#
# It is run BY and AT the base vehicle entity
# It is called from reds_vehicles:vehicle/root when more than
# zero events are defined

# Create a temporary buffer for the events list we can loop over
data modify storage reds_vehicles:events unchecked_events set from storage reds_vehicles:definitions current.events

# Perform loop
function reds_vehicles:events/try_event_loop with storage reds_vehicles:events unchecked_events[0]

# Clean up storage
data remove storage reds_vehicles:events unchecked_events
