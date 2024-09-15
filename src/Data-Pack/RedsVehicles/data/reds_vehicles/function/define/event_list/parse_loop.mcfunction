# This function handles the looping aspect of reds_vehicles:define/event_list/parse
#
# Does NOT return a success/failure code

# Pop the first element in the list
data modify storage reds_vehicles:definitions working_event set from storage reds_vehicles:definitions unprocessed_events[0]
data remove storage reds_vehicles:definitions unprocessed_events[0]

# Process events element
execute unless function reds_vehicles:define/event/parse run scoreboard players set vehicle.event_list_error vehicle.local 1

# Add processed element to processed array
data modify storage reds_vehicles:definitions processed_events append from storage reds_vehicles:definitions working_event

# Run again if unprocessed event entries remain
execute if data storage reds_vehicles:definitions unprocessed_events[0] run function reds_vehicles:define/event_list/parse_loop
