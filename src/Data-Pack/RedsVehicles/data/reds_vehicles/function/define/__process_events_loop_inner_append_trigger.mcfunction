# This is a function macro used by reds_vehicles:define/process_events_loop_inner to build trigger string
$data modify storage reds_vehicles:definitions predicate set value "unless score $(trigger) matches 0 "

# Successfully ran
return 1
