# Recursive loop that appends the string "vehicle.group." to all elements in a list.
# Each element is then added to the "extra_tags" list.
# This function is called by reds_vehicles:define/part/parse

# Take string stored in working_part.groups[0], prepend "vehicle.group." to it, and append the result to working_part.extra_tags
scoreboard players set vehicle.prepend_macro_status vehicle.local 0
data modify storage reds_vehicles:definitions args.string set from storage reds_vehicles:definitions working_part.groups[0]
execute store result score vehicle.prepend_macro_status vehicle.local run function reds_vehicles:define/part/__group_prepend_loop with storage reds_vehicles:definitions args
execute unless score vehicle.prepend_macro_status vehicle.local matches 1 run function reds_vehicles:define/part/report/group_prepend_macro_fail
execute unless score vehicle.prepend_macro_status vehicle.local matches 1 run return 0

# Remove element from list and run again if any remain
data remove storage reds_vehicles:definitions working_part.groups[0]
execute if data storage reds_vehicles:definitions working_part.groups[0] run return run function reds_vehicles:define/part/group_prepend_loop

# Return success
return 1
