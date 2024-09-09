# Cleans up temporary scores used in reds_vehicles:define/event_list/parse
scoreboard players reset vehicle.event_list_error vehicle.local
data remove storage reds_vehicles:definitions unprocessed_events
data remove storage reds_vehicles:definitions processed_events
data remove storage reds_vehicles:definitions working_event
