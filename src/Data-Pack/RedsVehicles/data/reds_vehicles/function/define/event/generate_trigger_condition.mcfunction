# This function generates the /execute condition from the provided trigger
#
# Return 1 on success
# Return 0 on macro fail

$data modify storage reds_vehicles:definitions working_event.predicate set value "unless score @s $(trigger) matches 0 "

# Success!
return 1
