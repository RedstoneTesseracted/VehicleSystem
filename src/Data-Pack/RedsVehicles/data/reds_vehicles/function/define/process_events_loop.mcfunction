# This function recursively parses entries in the vehicle's events list
#
# Before running this function, the contents of "working.events" are copied to "unprocessed_events"
# This function then pops and processes the first element of "unprocessed_events" before running again
#
# It is called from reds_vehicles:define/process_loop

scoreboard players set vehicle.asserted_local vehicle.local 0

# Pop the first element in the list
data modify storage reds_vehicles:definitions working_event set from storage reds_vehicles:definitions unprocessed_events[0]
data remove storage reds_vehicles:definitions unprocessed_events[0]

# Run inner function that we can terminate upon failure
execute store success score vehicle.success vehicle.local run function reds_vehicles:define/process_events_loop_inner
execute if score vehicle.success vehicle.local matches 0 run scoreboard players set vehicle.error vehicle.local 1

# Reset temporary scores
scoreboard players reset vehicle.action_id vehicle.local
scoreboard players reset vehicle.asserted_local vehicle.local

# Run again if entries remain in the events tag
execute if data storage reds_vehicles:definitions unprocessed_events[0] run function reds_vehicles:define/process_events_loop
