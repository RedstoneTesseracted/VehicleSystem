# Function macro that joins the trigger-based condition with the predicate-based condition
$data modify storage reds_vehicles:definitions working_event.predicate set value "$(working)$(append)"

# Success!
return 1
