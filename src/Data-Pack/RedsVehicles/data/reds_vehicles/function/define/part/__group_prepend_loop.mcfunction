# Macro called by ./group_prepend_loop
$data modify storage reds_vehicles:definitions working_part.extra_tags append value "vehicle.group.$(string)"

# Return macro success
return 1
