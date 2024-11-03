# This function uses a recursion-based loop to execute vehicle events
#
# It is run BY and AT the base vehicle entity
# It is called from reds_vehicles:events/process

# Execute the relevant event function
$execute $(predicate)run function reds_vehicles:events/execute_event

# Pop first element and run again any remain
data remove storage reds_vehicles:events unchecked_events[0]
execute if data storage reds_vehicles:events unchecked_events[0] run function reds_vehicles:events/try_event_loop with storage reds_vehicles:events unchecked_events[0]
